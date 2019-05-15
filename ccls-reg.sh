#!/bin/bash

# copy the flags file to a ccls file
# in same directory
cp .clang_complete .ccls

# add clang to the beginning of the file
echo "$(echo 'clang' | cat - .ccls)" > .ccls

# Done!
