#!/bin/bash
curl wttr.in/adelaide?format="%20%c%t%20\n" | sed 's/+//g'