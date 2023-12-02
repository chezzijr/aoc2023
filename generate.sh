#!/bin/bash
read -p "Enter the day: " num
read -p "Enter the template extension: " ext

# check if 1 <= num <= 25
if [ $num -lt 1 ] || [ $num -gt 25 ]
then
    echo "Invalid day"
    exit 1
fi

# check if ext in {cpp, py, rs, go, js, ts, zig}
if [ $ext != "cpp" ] && [ $ext != "py" ] && [ $ext != "rs" ] && [ $ext != "js" ] && [ $ext != "ts" ] && [ $ext != "zig" ]
then
    echo "Invalid extension"
    exit 1
fi

DIR="$num"
TEMPLATE_DIR="template"

if [ ! -d $DIR ]
then
    mkdir $DIR
fi

if [ ! -f $DIR/input.txt ]
then
    touch $DIR/input.txt
fi

if [ ! -f $DIR/main.$ext ]
then
    cp $TEMPLATE_DIR/main.$ext $DIR/main.$ext
fi
