import sys, os
if len(sys.argv) != 3:
    print('Usage: python build_charset.py <input_dir> <output_file>')
    sys.exit(1)
charset = set()
for root, dirs, files in os.walk(sys.argv[1]):
    for file in files:        
        if file.lower().endswith('.mst') or file.lower().endswith('.po'):
            file_path = os.path.join(root, file)
            for c in open(file_path, 'r', encoding='utf-8').read(): charset.add(c)
charset.remove('\n')
open(sys.argv[2], 'w', encoding='utf-8').write(''.join(sorted(charset)))
print('Found %d characters' % len(charset))