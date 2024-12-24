from requests import Session
from json import loads
import sys

endpoint = 'http://localhost:11434/api/chat'
model = 'hf.co/SakuraLLM/Sakura-7B-Qwen2.5-v1.0-GGUF'
system_prompt = '你是一个轻小说翻译模型，可以流畅通顺地以日本轻小说的风格将日文翻译成简体中文，并联系上下文正确使用人称代词，不擅自添加原文中没有的代词。'
line_prompt = lambda s: f'将下面的文本翻译成中文：{s}'
max_context = 8
options = {'temperature': 0.1, 'top_p': 0.3, 'max_tokens': 512,'frequency_penalty':0.1}
session = Session()
def slen(s):
    return sum(1 if ord(c) < 256 else 2 for c in s)
messages = list()
def query(s):
    global messages
    messages.append({'role':'user', 'content': line_prompt(s)})
    messages = messages[-max_context:]
    
    payload = [{'role':'system', 'content': system_prompt}] + messages    
    resp = session.post(endpoint, json={'model': model, 'messages':payload,'options':options,'stream':True},stream=True)
    content = ''
    print(s)    
    for line in resp.iter_lines():
        line = loads(line)
        text = line['message']['content']
        if not line['done']:
            content += text
            print(text,end='',flush=True)
        else:
            print()
            print('-' * max(slen(s),slen(content)))
            messages.append({'role':'assistant', 'content': content})
            return content    

if len(sys.argv) != 3:
    print('Usage: python ollama_translate.py <input file> <output file>')
    sys.exit(1)

with open(sys.argv[1], 'r', encoding='utf-8') as f:
    content = f.readlines()
# msgstr "100:[margin top=\"228\"]その瞳は、いつも僕を見つめていて。[unk19 index=\"60\"]"
def tokenize(s : str):    
    lstart = 0
    stk = 0
    for c in s[:-2]:        
        if c == '[': stk += 1
        if c == ']': stk -= 1
        flag = lstart and stk == 0 and c != ']'  
        if c == ':': lstart = True   
        yield (c, flag)
    yield (s[-2:], False) # "\n
for i, line in enumerate(content):
    if line.startswith('msgstr'):
        newline = ''
        bufline = ''
        for c, is_token in tokenize(line):
            if is_token:
                bufline += c
            else:
                if bufline:
                    newline += query(bufline)
                    bufline = ''
                newline += c
        if bufline:
            newline += query(bufline)
        content[i] = newline

with open(sys.argv[2], 'w', encoding='utf-8') as f:
    f.writelines(content)