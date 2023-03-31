#!/bin/bash
ifstat -n -i wlp3s0 2s | awk '{printf ("\n%02.1f ",$2)}'