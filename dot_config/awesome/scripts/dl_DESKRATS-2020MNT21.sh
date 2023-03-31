#!/bin/bash
ifstat -n -i enp5s0 2s | awk '{printf ("\n%02.1f ",$1)}'