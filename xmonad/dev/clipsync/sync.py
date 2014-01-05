#!/usr/bin/env python

import os
import subprocess

# As the str and bytes types cannot be mixed, you must always explicitly 
# convert between them. Use str.encode() to go from str to bytes, 
# and bytes.decode() to go from bytes to str. You can also use 
# bytes(s, encoding=...) and str(b, encoding=...), respectively.
input = bytes.decode(subprocess.check_output(["/usr/bin/xclip", "-o"]))

directory = os.environ['HOME']
xsel = open(directory + "/Archives/txt/CMD", "r+")

if input:

	mouseInput = input.replace('\n', '')
	mouseInput += "\n"
	match = False

	for line in xsel:
		if mouseInput == line:
			match = True
			break
	
	if match == False:
		xsel.write(mouseInput)
	
xsel.close()
