#!/usr/bin/ruby -w
#
# NOTE: Todo.rb requires the .todo configuration file to run.
# Place the .todo file in your home directory or use the -d option for a custom
# location.

def print(args)
  puts args+"\n\n"
end

def version()
  print("
  TODO.TXT Manager
  Version 0.1
  Original Author: Gina Trapani (ginatrapani@gmail.com)
  Ruby Porters: Jolts <johan@sharpcode.se>, Gigamo <gigamo@gmail.com>
  Release Date: TBA
  Last Updated: TBA
  License: GPL, http://www.gnu.org/copyleft/gpl.html
  More information at http://github.com/jolts/schatodo/")
  exit 1
end

def usage()
  print("
  Usage: todo.rb [-fhpqvV] [-d todo_config] action [task_number] [task_description]
  Try 'todo.sh -h' for more information.")
  exit 1
end

def help()
  print("TODO.")
  exit 1
end

def die(args)
  puts args
  exit 1
end

def cleanup()
  if File.exists? TMP_FILE then IO.popen("rm #{TMP_FILE}") {} end
end

# == PROCESS OPTIONS ==
# defaults
VERBOSE  = 0
PLAIN    = 0
CFG_FILE = "#{ENV["HOME"]}/.todo"
FORCE    = 0


## Testing output
version()
