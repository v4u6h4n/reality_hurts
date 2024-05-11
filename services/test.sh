#!/usr/bin/env bash

clear  

input="Hello world!"

tput cup 0 0

while true; do
    for colour in colours; do
        echo "\033$input\033[0m"
        sleep 0.1
        tput cup 0 0
    done
done


#!/usr/bin/env bash

clear  

input="Hello world!"
colors=(31 33 32 34 36 35)  # Red, Yellow, Green, Blue, Cyan, Purple

tput cup 0 0

while true; do
    # Calculate the color index based on elapsed time
    color_index=$(( SECONDS % ${#colors[@]} ))
    
    # Get the current color code from the colors array
    color_code="${colors[$color_index]}m"
    
    # Print the entire input string with the current color
    echo -en "\033[${color_code}${input}\033[0m"
    
    
    tput cup 0 0
done
