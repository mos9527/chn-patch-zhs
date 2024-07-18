import sys, os
from collections import defaultdict
if len(sys.argv) != 3:
    print('Usage: python generate_mst.py  <output dir> <input dir>')
    sys.exit(1)
id_index = 'msgid '
language_index = 'msgstr '
for root, dirs, files in os.walk(sys.argv[2]):
    for file in files:
        if file.lower().endswith('.po'):
            file_path = os.path.join(root, file)
            output_path = os.path.join(sys.argv[1], file.split('.')[0] + '.mst')
            with open(file_path, 'r', encoding='utf-8') as fin:
                with open(output_path, 'w', encoding='utf-8') as fout:
                    lines = fin.readlines()
                    ids = (line[len(id_index)+1:-2] for line in lines if str(line).startswith(id_index))
                    strs = (line[len(language_index)+1:-2] for line in lines if str(line).startswith(language_index))
                    for iid, sstr in zip(ids, strs):
                        if iid:
                            if sstr: fout.write('%s\n' % sstr)
                            else: fout.write('%s\n' % iid)
