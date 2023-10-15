#!/bin/bash
# Ram as percentage
# free | awk '/Mem/{printf("%02.0f% "), $3/$2*100}'

# Ram in MB
#free --mega | awk '/Mem/{printf("R:%04.0fMB "), $3}'
free --mega | awk '/Mem/{printf("%0f"), $2/$3}'
