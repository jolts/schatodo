#!/usr/bin/env ruby
# Rudo.rb todo manager.
# Author: Gigamo <gigamo@gmail.com>, Jolts <johan@sharpcode.se>
# Inspired by Todo.txt (http://www.todotxt.com)
# which was written by Gina Trapani.

$todo_dir = "#{ENV["HOME"]}/.todotxt"
$todo_file = "#{$todo_dir}/todo.txt"

def usage
  "Rudo.rb by Gigamo <gigamo@gmail.com>
  Usage: rudo.rb <ACTION> <ARGUMENTS>

    For example:

      * rudo.rb add My new todo item.
      * rudo.rb append <tasknumber> My appended text
      * rudo.rb del <tasknumber>
      * rudo.rb done <tasknumber
      * rudo.rb replace <tasknumber> My replacing text
      * rudo.rb list"
end

def get_tasks
  # Returns a hash of all tasks found in $todo_file
  count = 0
  tasks = Hash.new # tasks = {}
  File.open($todo_file).each_line { |line|
    if line.strip == "": next end
    count += 1
    tasks[count] = line.chomp
  }
  tasks
end

def write_tasks(task_dict)
  # Writes tasks to $todo_file
  keys = task_dict.keys
  keys.sort
  f = File.open($todo_file, "w")
  keys.each { |key| f.write(task_dict[key]+"\r\n") }
  f.close
end

def add(text)
  # Adds a new task to $todo_file
  f = File.open($todo_file, "a")
  f.write(text+"\r\n")
  f.close
end

def append(item, text="")
  # Appends text to a given task in $todo_file
  tasks = get_tasks
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit
  end
  tasks[item] = "" << [tasks[item], text].join(" ")
  write_tasks(tasks)
end

def delete(item)
  # Deletes task by the given tasknumber in $todo_file
  tasks = get_tasks
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit
  end
  tasks.delete(item)
  write_tasks(tasks)
end

def done(item)
  # Marks the given tasknumber as done in $todo_file
  tasks = get_tasks
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit
  end
  date = Time.now.strftime("%d/%m/%Y")
  tasks[item] = "" << ["x", date, tasks[item]].join(" ")
  write_tasks(tasks)
  puts "Tasknumber %d was marked as done." % item
end

def list(patterns=nil)
  # Prints a list of all current tasks and their tasknumbers in $todo_file
  items = Array.new # items = []
  tasks = get_tasks
  if patterns
    tasks.each { |key, value|
      match = true
      patterns.each { |pattern| unless /#{pattern}/ix.match(value): match = false end }
      if match: items << "  #{key}: #{value}" end
    }
  else
    tasks.each { |key, value| items << "  #{key}: #{value}" }
  end
  items.sort
  items.each { |item| puts item }
end

def replace(item, text)
  # Replaces the text in a given task in $todo_file
  tasks = get_tasks
  unless tasks.has_key?(item)
    puts "#{item}: No such todo."
    exit
  end
  tasks[item] = text
  write_tasks(tasks)
end



begin
  if ARGV.empty?
    puts usage
    exit
  else
    @action = ARGV[0]
    @args = ARGV[1..-1]
  end

  if @action == "add"
    if @args
      add("" << @args.join(" "))
    end
  elsif @action == "append"
    if @args.length > 1
      append(@args[0].to_i, "" << @args[1..-1].join(" "))
    end
  elsif @action == "del"
    if @args.length == 1
      delete(@args[0].to_i)
    end
  elsif @action == "list"
    if @args.length > 0
      list(@args.join(" "))
    else
      list
    end
  elsif @action == "replace"
    if @args.length > 1
      replace(@args[0].to_i, "" << @args[1..-1].join(" "))
    end
  elsif @action == "done"
    if @args.length == 1
      done(@args[0].to_i)
    end
  end
end
