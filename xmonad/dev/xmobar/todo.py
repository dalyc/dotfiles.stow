#!/usr/bin/env python

# The todo program allows me to see in xmobar if I have completed a weekly task.
# todo.py allows me to mark tasks as done or undone, or reset all tasks as undone.
# The file containing all the tasks is todo.txt; it follows the format 'task_one=0'
# where 0 means undone and 1 means done.
#
# Todo program consists of three files: todo.py, todo(bash script), and todo.txt.

import sys
import os
import fileinput

def initialize_activities():
# Initiate a list of all the activities {{{
    global activities_completed
    global activities_uncompleted
    todo = open(directory + "/todo.txt", "r")
    for line in todo:
        if "=1" in line:
            index = line.rfind('=')
            activities_completed.append(line[:index])
        elif "=0" in line:
            index = line.rfind('=')
            activities_uncompleted.append(line[:index])
    todo.close()
# }}}

def update_activities(line):
# Update all the activities {{{
    global activities_completed
    global activities_uncompleted

    # Keep activities_uncompleted and activities_completed
    # up to date
    index = line.find('=')
    if sys.argv[1] == "reset" and index != "-1":
        activities_completed.remove(line[:index])
        activities_uncompleted.append(line[:index])
    elif sys.argv[1] == "undone":
        activities_completed.remove(sys.argv[2])
        activities_uncompleted.append(sys.argv[2])
    elif sys.argv[1] == "done":
        activities_uncompleted.remove(sys.argv[2])
        activities_completed.append(sys.argv[2])
# }}}

def update_todo_file(conditional, original, replaced):
# Update the specified todo file {{{
    for line in fileinput.input([directory + '/todo.txt'], inplace=True):
        if conditional in line:
            print(line.replace(original, replaced).rstrip("\n"))
            update_activities(line)
        else:
            print(line.rstrip("\n"))
# }}}

# Get dir path of where this script resides, so that todo.txt
# can be opened when script is run from another dir.
# Also, strip the basename.
directory = os.path.realpath(__file__)
directory = directory[:directory.rfind('/')]

activities_completed = []
activities_uncompleted = []
initialize_activities()

if len(sys.argv) == 2 and sys.argv[1] == "reset":
    update_todo_file("=1", "=1", "=0")
    # TODO: Add database code

if len(sys.argv) == 3:

    if sys.argv[1] == "done" and sys.argv[2] in activities_uncompleted:
        update_todo_file(sys.argv[2], "=0", "=1")

    if sys.argv[1] == "undone" and sys.argv[2] in activities_completed:
        update_todo_file(sys.argv[2], "=1", "=0")

print("Completed:   ", activities_completed)
print("Uncompleted: ", activities_uncompleted)
