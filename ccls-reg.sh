#!/bin/bash

# copy the flags file to a ccls file
# in same directory
cp .clang_complete .ccls

# add text "clang" to the beginning of the file
# so that ccls will recognize it as a compile_commands file
echo "$(echo 'clang' | cat - .ccls)" > .ccls

# Done!
