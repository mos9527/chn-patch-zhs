import sys, os
if len(sys.argv) != 3:
    print('Usage: python update_config.py charset.utf8 patchdef.json')
    sys.exit(1)
from json import load, dump
charset = open(sys.argv[1], 'r', encoding='utf-8').read()
patchdef = load(open(sys.argv[2], 'r', encoding='utf-8'))
patchdef['base']['charset'] = charset
dump(patchdef, open(sys.argv[2], 'w', encoding='utf-8'), indent=2, ensure_ascii=False)
