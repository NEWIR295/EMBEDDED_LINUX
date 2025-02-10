#!/bin/bash

#Author: Mohamed Newir
#Date: 10/02/2025
#Title: ch2.sh
#Description: renaming .jpg files to include the date in it name format: YYYY-MM-DD-<filename>.jpg

#!/bin/bash
date=$(date +"%Y-%m-%d")
dir="."
for image in ${dir}/*.jpg;
do
    fileName=$(basename "$image")
    newName="${date}-${fileName}"
    mv "$image" "$newName"
    echo "renamed ${fileName} to ${newName}"
done

echo "All files have been renamed"