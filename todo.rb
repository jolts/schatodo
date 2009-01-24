#!/usr/bin/env ruby

# TODO.TXT Manager
# Author:     Jolts <johan@sharpcode.se>, Gigamo <gigamo@gmail.com>
# Concept by: Gina Trapani >ginatrapani@gmail.com>
# License:    GPL, http://www.gnu.org/copyleft/gpl.html
# Version:    0.1-rb
# More info:  http://todotxt.com, http://github.com/jolts/schatodo

TODO_DIR     = "#{ENV["HOME"]}/.todotxt" # THIS IS MY DIRECTORY JOLTS I DONT KNOW YOURS
TODO_FILE    = "#{TODO_DIR}/todo.txt"
DONE_FILE    = "#{TODO_DIR}/done.txt"
REPORT_FILE  = "#{TODO_DIR}/report.txt"
TMP_FILE     = "#{TODO_DIR}/todo.tmp"

NONE         = ""
BLACK        = "\033[0;30m"
RED          = "\033[0;31m"
GREEN        = "\033[0;32m"
BROWN        = "\033[0;33m"
BLUE         = "\033[0;34m"
PURPLE       = "\033[0;35m"
CYAN         = "\033[0;36m"
LIGHT_GREY   = "\033[0;37m"
DARK_GREY    = "\033[1;30m"
LIGHT_RED    = "\033[1;31m"
LIGHT_GREEN  = "\033[1;32m"
YELLOW       = "\033[1;33m"
LIGHT_BLUE   = "\033[1;34m"
LIGHT_PURPLE = "\033[1;35m"
LIGHT_CYAN   = "\033[1;36m"
WHITE        = "\033[1;37m"
DEFAULT      = "\033[0m"

# === PRIORITY COLORS ===
PRI_A = YELLOW   # color for A priority
PRI_B = GREEN  # color for B priority
PRI_C = LIGHT_BLUE   # color for B priority
PRI_X = WHITE   # color for rest of them

def usage()
  text = "  Usage: #{ARGV[0]} [options] [ACTION] [PARAM...]

  Actions:
    add \"THING I NEED TO DO p:project @context\"
      Adds TODO ITEM to your todo.txt.
      Project and context notation optional.
      Quotes optional.
  
    append NUMBER \"TEXT TO APPEND\"
      Adds TEXT TO APPEND to the end of the todo on line NUMBER.
      Quotes optional.
  
    archive
      Moves done items from todo.txt to done.txt.
  
    del NUMBER
      Deletes the item on line NUMBER in todo.txt.
  
    do NUMBER
      Marks item on line NUMBER as done in todo.txt.
  
    ls [TERM] [[TERM]...]
      Displays all todo's that contain TERM(s) sorted by priority with line
      numbers.  If no TERM specified, lists entire todo.txt.
  
    lspri [PRIORITY]
      Displays all items prioritized PRIORITY.
      If no PRIORITY specified, lists all prioritized items.
  
    pri NUMBER PRIORITY
      Adds PRIORITY to todo on line NUMBER.  If the item is already
      prioritized, replaces current priority with new PRIORITY.
      PRIORITY must be an uppercase letter between A and Z.
  
    replace NUMBER \"UPDATED TODO\"
      Replaces todo on line NUMBER with UPDATED TODO.
  
    remdup
      Removes exact duplicate lines from todo.txt.
  
    report
      Adds the number of open todo's and closed done's to report.txt.
  
  Options:
    -nc : Turns off colors

  More on the todo.txt manager at
  http://todotxt.com
  Version 1.5.2-python
  Copyleft 2006, Gina Trapani (ginatrapani@gmail.com)
  Copyleft 2008, Jolts (johan@sharpcode.se), Gigamo (gigamo@gmail.com)"
  
  puts text
end

## Start functions

def get_task_dict()
end

def get_done_dict()
end

def write_tasks(task_dict)
end

def write_done(done_dict)
end

def add(text)
    todo_file = File.new(TODO_FILE, 'a') 
    todo_file.puts(text)
    todo_file.close
end

def append(item, text)
end

def archive()
end

def delete(item)
end

def do(item)
end

def list(patterns=None) ## Not sure if this is correct
end

def alpha_sort(a, b)
end

def highlight_priority(matchobj)
end

def prioritize(item, newpriority)
end

def replace(item, text)
end

def remove_duplicates()
end

def report()
end

## Start program
begin
  # ...
rescue Exception => exp
  $stderr.puts "Error: %s" % exp.message
end
