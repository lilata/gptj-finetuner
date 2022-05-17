#! /usr/bin/env python3
import math
import sys
import os
output = ',text\n'
cnt = 0
for file in sys.argv[1:]:
    with open(file) as f:
        text = f.read().strip().replace('\n', ' ').replace('\t', '').replace('"', '""')
        splitted = text.split(' ')
        for n in range(math.ceil(len(splitted) / 800)):
            output = f'{output}\n{cnt},"<|endoftext|>{" ".join(splitted[n*800: 800*(n+1)])}<|endoftext|>"'
            cnt += 1

with open('train.csv', 'w') as f:
    f.write(output)


with open('validation.csv', 'w') as f:
    f.write(',text')
