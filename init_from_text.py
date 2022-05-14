#! /usr/bin/env python3
import sys
import os
output = ',text'
cnt = 0
for file in sys.argv[1:]:
    with open(file) as f:
        text = f.read().strip().replace('\n', ' ').replace('\t', '').replace('"', '""')
        output = f'{output}\n{cnt},"<|endoftext|>{text}<|endoftext|>"'
        cnt += 1

with open('train.csv', 'w') as f:
    f.write(output)


with open('validation.csv', 'w') as f:
    f.write(',text')
