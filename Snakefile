# first, gather all '.fa' and '.fna' files
import os
import random

all_files = []
for root, dirs, files in os.walk(".", topdown=False):
    for name in files:
        if name.endswith('.fa') or name.endswith('.fna'):
            filename = os.path.join(root, name)
            if filename.startswith('./'): filename = filename[2:]
            all_files.append(filename)

print('found {} files'.format(len(all_files)))
random.shuffle(all_files)
print('examples:', all_files[:5])

# rule all: make sigs
rule all:
    input:
        [ x + '.sig' for x in all_files ]

# generic rule: compute signature
rule compute_sig:
    input:
	"{filename}"
    output:
        "{filename}.sig"
    shell:
        "sourmash compute -k 31 --scaled=10000 {filename} -o {output}"
