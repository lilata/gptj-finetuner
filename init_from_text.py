#! /usr/bin/env python3
import sys
import os
output = ',text'
cnt = 0
for file in sys.argv[1:]:
    with open(file) as f:
        all_text = f.read().split('\n')
        for text in all_text:
            text = text.strip()
            if not text:
                continue
            output = f'{output}\n{cnt},<|endoftext|>{text}<|endoftext|>'
            cnt += 1

with open('train.csv', 'w') as f:
    f.write(output)


with open('validation.csv', 'w') as f:
    f.write(',text')
