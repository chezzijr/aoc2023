#!/bin/bash
read -p "Enter the day: " num

if [ $num -lt 1 ] || [ $num -gt 25 ]
then
    echo "Invalid day"
    exit 1
fi

DIR="$num"
BIN_DIR="bin"

if [ ! -d $DIR ]
then
    echo "Directory does not exist"
    exit 1
fi

if [ ! -f $DIR/input.txt ]
then
    echo "input.txt does not exist"
    exit 1
fi

# check main file with any extension
if [ ! -f $DIR/main.* ]
then
    echo "main file does not exist"
    exit 1
fi

if [ ! -d $BIN_DIR ]
then
    mkdir $BIN_DIR
fi

# get extension of main file
ext=$(ls $DIR/main.* | cut -d'.' -f2)
bin_file="${num}_${ext}"
if [[ "$ext" = "cpp" ]]
then
    g++ $DIR/main.cpp -o $BIN_DIR/$bin_file
    ./$BIN_DIR/$bin_file $DIR/input.txt
elif [[ "$ext" = "py" ]]
then
    python3 $DIR/main.py $DIR/input.txt
elif [[ "$ext" = "rs" ]]
then
    rustc $DIR/main.rs -o $BIN_DIR/$bin_file
    ./$BIN_DIR/$bin_file $DIR/input.txt
elif [[ "$ext" = "js" ]]
then
    node $DIR/main.js $DIR/input.txt
elif [[ "$ext" = "ts" ]]
then
    tsc $DIR/main.ts -o $BIN_DIR/$bin_file
    ./$BIN_DIR/$bin_file $DIR/input.txt
elif [[ "$ext" = "zig" ]]
then
    zig run $DIR/main.zig -- $DIR/input.txt
else
    echo "Invalid extension"
    exit 1
fi
