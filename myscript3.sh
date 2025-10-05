#!/bin/bash

# Default values
input_file="usernames.txt"
filename="tarball.tar.gz"

# Periptwseis twn arguments
case $# in
    2) # 2 arguments
        input_file="$1"
        filename="$2"
        ;;
    1) # 1 argument
 	if [[ -f "$1" ]]; then
            # If it's a file, assume it's the input file
            input_file="$1"
        else
            # Otherwise, assume it's the filename
            filename="$1"
        fi
        ;;
    0)
        # mhn kaneis kati, xrhsimopoihse ta defaults
        ;;
    *)
        echo "Error: Invalid number of arguments."
        exit 1
        ;;
esac

# Elegxei an to input_file uparxei
if [[ ! -f "$input_file" ]]; then
    echo "Error: Input file '$input_file' not found!"
    exit 1
fi

# Diabazei kathe onoma
while read -r username; do
    # Elegxos uparjhs directory
    home_dir="/home/$username"
    if [[ -d "$home_dir" && ! -x "$home_dir" ]]; then
        echo "$username"
        echo "##########"
        echo "$filename: Permission denied."
        echo ""
        continue
    fi

    # Elegxos uparjhs file
    file_path="$home_dir/$filename"
    # Elegxos uparjhs file_path
    if [[ -f "$file_path" ]]; then
        file_size=$(stat -c%s "$file_path") #stores the size in bytes into file_size
        echo "$username"
        echo "##########"
        echo "$filename: File found, size $file_size bytes."
        echo ""
    else
        echo "$username"
        echo "##########"
        echo "$filename: File not found."
        echo ""
    fi
done < "$input_file"

