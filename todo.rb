#!/usr/bin/ruby -w
#
# NOTE: Todo.rb requires the .todo configuration file to run.
# Place the .todo file in your home directory or use the -d option for a custom
# location.

# == PROCESS OPTIONS ==
# defaults
VERBOSE  = 0
PLAIN    = 0
CFG_FILE = "#{ENV["HOME"]}/.todo"
TODO_FILE = "#{ENV["HOME"]}/todo/todo.txt"
FORCE    = 0

def add(text)
    todo_file = File.new(TODO_FILE, 'a') 
    todo_file.puts(text)
    todo_file.close
end

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
  print("
      Usage:  todo.rb [-fhpqvV] [-d todo_config] action [task_number] [task_description]

      Actions:
        add \"THING I NEED TO DO p:project @context\"
        a \"THING I NEED TO DO p:project @context\"
          Adds TODO ITEM to your todo.txt.
          Project and context notation optional.
          Quotes optional.

        append NUMBER \"TEXT TO APPEND\"
        app NUMBER \"TEXT TO APPEND\"
          Adds TEXT TO APPEND to the end of the todo on line NUMBER.
          Quotes optional.

        archive
          Moves done items from todo.txt to done.txt.

        del NUMBER
        rm NUMBER
          Deletes the item on line NUMBER in todo.txt.

        do NUMBER
          Marks item on line NUMBER as done in todo.txt.

        list [TERM...] 
        ls [TERM...]
          Displays all todo's that contain TERM(s) sorted by priority with line
          numbers.  If no TERM specified, lists entire todo.txt.

        listall [TERM...]
        lsa [TERM...]
          Displays all the lines in todo.txt AND done.txt that contain TERM(s)
          sorted by priority with line  numbers.  If no TERM specified, lists
          entire todo.txt AND done.txt concatenated and sorted.

        listpri [PRIORITY]
        lsp [PRIORITY]
          Displays all items prioritized PRIORITY.
          If no PRIORITY specified, lists all prioritized items.

        prepend NUMBER \"TEXT TO PREPEND\"
        prep NUMBER \"TEXT TO PREPEND\"
          Adds TEXT TO PREPEND to the beginning of the todo on line NUMBER.
          Quotes optional.

        pri NUMBER PRIORITY
        p NUMBER PRIORITY
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
        -d CONFIG_FILE
            Use a configuration file other than the default ~/.todo
        -f
        	Forces actions without confirmation or interactive input
        -h
            Display this help message
        -p
            Plain mode turns off colors
        -v 
            Verbose mode turns on confirmation messages
        -V 
            Displays version, license and credits")
  exit 1
end

def die(args)
  puts args
  exit 1
end

def cleanup()
  if File.exists? TMP_FILE then IO.popen("rm #{TMP_FILE}") {} end
end

## Testing output
help()
