###########
# Options #
###########
# Save readline history
set history filename ~/.local/share/gdb/histfile
set history save on
# Debug in record mode (allows for reverse execution)
set record full
# Disable limit for printing of vars
set print elements 0
# Pimp my prompt
set prompt \033[31m[gdb] \033[0m
# Disables GDB output of certain info messages
set verbose off
# Use intel assembly syntax instead of AT&T
set disassembly-flavor intel
# Use PEDA
# source ~/.local/share/gdb/peda.py
