#!/bin/bash

# 명령줄 인수에서 값을 읽어와 변수에 할당
character="$1"

# main.py 스크립트를 실행하는 명령
python main.py --character "$character" --input cam --debug --extend_movement 1 --simplify 0 --cache 8gb --gpu_cache 4gb --model standard_float --output_size 512x512