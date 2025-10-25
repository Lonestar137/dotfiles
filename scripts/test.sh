#!/usr/bin/env bash

# Test script for the jpgify.py script

rm -rf Screenshots/
tar xf ./Screenshots.tar.gz
pushd Screenshots/
  # time $(uv run ../jpgify.py > "../output.txt") > "../new.txt"
  time uv run ../jpgify.py && echo "Done" > "../new.txt"
popd

du -h ./Screenshots >> "new.txt"

cat new.txt
