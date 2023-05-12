#!/bin/bash

large_files="${1:-fuzzer_cov_data.csv}"

for file in $large_files; do
    echo "Compressing: $file"
    
    xz -9 -T 3 $file
done

echo "Done!"