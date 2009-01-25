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
  Version 0.1-ruby
  Copyleft 2006, Gina Trapani (ginatrapani@gmail.com)
  Copyleft 2008, Jolts (johan@sharpcode.se), Gigamo (gigamo@gmail.com)"
  
  puts text
end

## Start functions

def get_task_dict()
  # A utility method to obtain a dictionary of tasks from the TODO file
  count = 0
  tasks = {}
  f = File.open(TODO_FILE)
  for line in f.readlines
    if line.strip == ""
      count = count + 1
      tasks[count] = line.chomp
    end
  end
  return tasks
end

def get_done_dict()
  # A utility method to obtain a dictionary of tasks from the DONE file
  count = 0
  tasks = {}
  f = File.open(DONE_FILE)
  for line in f.readlines
    if line.strip == ""
      count = count + 1
      tasks[count] = line.chomp
    end
  end
  return tasks
end

def write_tasks(task_dict)
  # a utility method to write a dictionary of tasks to the TODO file
  keys = task_dict.keys
  keys.sort
  if File.exists?(TODO_FILE)
    f = File.open(TODO_FILE, "w")
  else
    f = File.new(TODO_FILE, "w")
  end
  for key in keys
    f.write(task_dict[key]+"\n")
  end
  f.close
end

def write_done(done_dict)
  # a utility method to write a dictionary of tasks to the DONE file
  keys = done_dict.keys
  keys.sort
  if File.exists?(DONE_FILE)
    f = File.open(DONE_FILE, "w")
  else
    f = File.new(DONE_FILE, "w")
  end
  for key in keys
    f.write(done_dict[key]+"\n")
  end
  f.close
end

def add(text)
  if File.exists?(TODO_FILE)
    f = File.open(TODO_FILE, "a")
  else
    f = File.new(TODO_FILE, "a")
  end
  f.puts(text+"\n")
  f.close
end

def append(item, text)
  # Append text to a given task
  tasks = get_task_dict()
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit 1
  end
  tasks[item] = " ".insert(-1, [tasks[item], text])
  write_tasks(tasks)
end

def archive()
  # TODO
end

def delete(item)
  tasks = get_task_dict()
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit 1
  end
  tasks.delete(item)
  write_tasks(tasks) 
end

def doing(item)
  tasks = get_task_dict()
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit 1
  end
  date = (Time.now.utc + 1 * 3600).strftime("%Y-%m-%d")
  tasks[item] = " ".insert(-1, "x", date, tasks[item])
  write_tasks(tasks)
  puts "#{item} marked as done."
end

def list(patterns=None) ## Not sure if this is correct
  # TODO
end

def alpha_sort(a, b)
  # TODO
end

def highlight_priority(matchobj)
  # TODO
end

def prioritize(item, newpriority)
  # TODO
end

def replace(item, text)
  # Replace text to a given task
  tasks = get_task_dict()
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit 1
  end
  tasks[item] = text
  write_tasks(tasks)
end

def remove_duplicates()
  # TODO
end

def report()
  archive() # FUNCTION NOT WRITTEN

  @active = get_task_dict() # FUNCTION NOT WRITTEN
  @closed = get_done_dict() # FUNCTION NOT WRITTEN

  @date = (Time.now.utc + 1 * 3600).strftime("%Y-%m-%d-%T")

  string = "#{@date} #{@active.length} #{@closed.length}"

  if File.exists?(REPORT_FILE)
    f = File.open(REPORT_FILE, "a")
  else
    f = File.new(REPORT_FILE, "a")
  end
  f.puts(string+"\n")
  f.close
end

## Start program

begin
  if ARGV[0] == "-h" or ARGV.length < 2
    usage()
    exit 1
  else
    if ARGV[1] == "-nc"
      PRI_A = NONE
      PRI_B = NONE
      PRI_C = NONE
      PRI_X = NONE
      @action = ARGV[2]
      @args = ARGV[3..-1]
    else
      @action = ARGV[1]
      @args = ARGV[2..-1]
    end
  end

  if @action == "add"
    if @args # .exists? not sure.
      add("".insert(-1, @args))
    else
      puts "Usage: #{ARGV[0]} add TEXT [p:PROJECT] [@CONTEXT]"
    end
  
  elsif @action == "append"
    if @args.length > 1 and @args[0].kind_of?(Integer)
      append(@args[0].to_i, "".insert(-1, @args[1..-1]))
    else
      puts "Usage: #{ARGV[0]} append <item_num> TEXT"
    end
  
  elsif @action == "archive"
    archive()

  elsif @action == "del"
    if @args.length == 1 and @args[0].kind_of?(Integer)
      delete(@args[0].to_i)
    else
      puts "Usage: #{ARGV[0]} del <item_num>"
    end

  elsif @action == "do"
    if @args.length == 1 and @args[0].kind_of?(Integer)
      doing(@args[0].to_i)
    else
      puts "Usage: #{ARGV[0]} do <item_num>"
    end
    
  elsif @action == "ls" or @action == "list"
    if @args.length > 0
      list(@args)
    else
      list()
    end

  elsif @action == "lspri" or @action == "listpri"
    if @args.length > 0
      x = ["\([#{@args[0]}]\)"] # No idea if this regexp is correct
    else
      x = ["\([A-Z]\)"] # Same as above
    end
    list(x)

  elsif @action == "pri"
    if @args.length == 2 and @args[0].kind_of?(Integer) and @args[1].kind_of?(String)
      prioritize(@args[0].to_i, @args[1])
    elsif @args.length == 1 and @args[0].kind_of?(Integer)
      prioritize(@args[0].to_i, "")
    else
      puts "Usage: #{ARGV[0]} pri <item_num> [PRIORITY]"
    end

  elsif @action == "replace"
    if @args.length == 2 and @args[0].kind_of?(Integer)
      replace(@args[0].to_i, " ".insert(-1, @args[1..-1]))
    else
      puts "Usage: #{ARGV[0]} replace <item_num> TEXT"
    end

  elsif @action == "remdup"
    remove_duplicates()

  elsif @action == "report"
    report()
  
  else
    usage()
  end
rescue Exception => exp
  $stderr.puts "Error: #{exp.message}"
end
