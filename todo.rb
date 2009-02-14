#!/usr/bin/env ruby
=begin

Author: Gigamo <gigamo@gmail.com>
Inspired by Todo.txt (http://www.todotxt.com)

Usage: rudo <ACTION> <ARGUMENTS>

  For example:

    * rudo add My new todo item.
    * rudo append <tasknumber> My appended text
    * rudo replace <tasknumber> My replacing text
    * rudo del <tasknumber>
    * rudo done <tasknumber
    * rudo list <match> (regexp)

=end

module Rudo
  extend self

  @@todo_file = "#{ENV["HOME"]}/.todotxt//todo.txt"

  def usage
    "Usage:\n  " + File.read(__FILE__).match(/Usage:(.+?)=end/m)[1].strip
  end

  def get_tasks
    count = 0
    tasks = Hash.new # tasks = {}
    File.open(@@todo_file).each_line { |line|
      if line.strip == '': next end
      count += 1
      tasks[count] = line.chomp
    }
    tasks
  end

  def write_tasks(task_dict)
    keys = task_dict.keys.sort
    f = File.open(@@todo_file, 'w')
    keys.each { |key| f.write("#{task_dict[key]}\r\n") }
    f.close
  end

  def add(text)
    f = File.open(@@todo_file, 'a')
    f.write("#{text}\r\n")
    f.close
  end

  def append(item, text="")
    tasks = get_tasks
    unless tasks.has_key?(item)
      puts "#{item}: No such todo."
      exit
    end
    tasks[item] = [tasks[item], text].join(' ')
    write_tasks(tasks)
  end

  def replace(item, text)
    tasks = get_tasks
    unless tasks.has_key?(item)
      puts "#{item}: No such todo."
      exit
    end
    tasks[item] = text
    write_tasks(tasks)
  end

  def delete(item)
    tasks = get_tasks
    unless tasks.has_key?(item)
      puts "#{item}: No such todo."
      exit
    end
    tasks.delete(item)
    write_tasks(tasks)
  end

  def done(item)
    tasks = get_tasks
    unless tasks.has_key?(item)
      puts "#{item}: No such todo."
      exit
    end
    date = Time.now.strftime("%d/%m/%Y")
    tasks[item] = ['x', date, tasks[item]].join(' ')
    write_tasks(tasks)
    puts "Tasknumber #{item} was marked as done."
  end

  def list(patterns=nil)
    items = Array.new
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
    items.sort.each { |item| puts item }
  end

  def read(arguments)
    @action = arguments.first
    @args = arguments[1..-1]

    case @action
    when 'add'
      Rudo.add(@args.join(' ')) unless @args.nil?
    when 'append'
      Rudo.append(@args.first.to_i, @args[1..-1].join(' ')) unless @args.length < 1
    when 'replace'
      Rudo.replace(@args.first.to_i, @args[1..-1].join(' ')) unless @args.length < 1
    when 'del'
      Rudo.delete(@args.first.to_i) if @args.length == 1
    when 'done'
      Rudo.done(@args.first.to_i) if @args.length == 1
    when 'list'
      if @args.nil?: Rudo.list
      else Rudo.list(@args) end
    else
      puts usage
      exit
    end
  end
end

Rudo.read(ARGV) if $0 == __FILE__
