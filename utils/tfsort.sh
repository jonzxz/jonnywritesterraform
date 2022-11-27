#!/bin/bash

for file_output in $@; do 
  cat $file_output | awk -f utils/tfsort.awk | tee ${file_output:0:-3}.tf > /dev/null
  git diff --color | cat
done