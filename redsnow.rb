#!/usr/bin/env ruby
require 'curses'

#Curses.noecho
#Curses.nonl
#Curses.stdscr.keypad(true)
#Curses.raw
#Curses.stdscr.nodelay = 1

Curses.init_screen


Curses.start_color

Curses.init_pair(1, Curses::COLOR_WHITE, Curses::COLOR_BLACK)

window = Curses::Window.new(100,100,0,0)

window.color_set(1)

window.setpos(0,0)
window.clear

#window.addstr("This is a testing string")

window.refresh

count=0
until false
  window.clear
  window.addstr "#{count}"
  count = count + 1
  window.refresh
  sleep 1

end
