#!/bin/bash
free | awk '/Mem/{printf("%02.0f% "), $3/$2*100}'