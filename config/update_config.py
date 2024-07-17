import sys, os
if len(sys.argv) != 4:
    print('Usage: python update_config.py charset.utf8 charset.json patchdef.json')
    sys.exit(1)
from json import load, dump
charset = open(sys.argv[1], 'r', encoding='utf-8').read()
charset_ext = load(open(sys.argv[2], 'r', encoding='utf-8'))
patchdef = load(open(sys.argv[3], 'r', encoding='utf-8'))
patchdef['base']['charset'] = charset
patchdef['base']['extendedcharset'] = charset_ext
dump(patchdef, open(sys.argv[3], 'w', encoding='utf-8'), indent=2, ensure_ascii=False)
