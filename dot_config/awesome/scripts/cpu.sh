#!/bin/bash
echo $(vmstat 1 2|tail -1|awk '{printf("%0.0f", 100-$15)}')
