#!/usr/bin/env ruby
require 'curses'

class RedSnow

  SLEEP_TIME = 0.01
  FLAKE_FACTOR = 2

  class Flake
    attr_accessor :x, :y, :vert_speed, :horz_speed, :symbol
    def initialize
      @x=(rand * Curses.cols).round
      @y=0
      @vert_speed=0.3 + (rand/4)
      @horz_speed=(0.5 - rand)/2
      @symbol=(rand > 0.5) ? "*" : "."
      if @symbol == "*" then @horz_speed = @horz_speed * 2 end
    end
  end

  def initialize
    Curses.init_screen
    Curses.start_color
    Curses.init_pair 1, Curses::COLOR_WHITE, Curses::COLOR_BLACK
    Curses.curs_set 0
    Curses.echo
    Curses.cbreak
    Curses.nl
    @window = Curses::Window.new(0,0,0,0)
    @window.color_set(1)
    @window.setpos 0,0
    @window.clear
    @window.refresh
    @flakes=[]
    num_flakes = (Curses.cols * FLAKE_FACTOR).round
    num_flakes.times do |i|
      @flakes[i] = Flake.new
      @flakes[i].y = rand * Curses.lines
    end

    # trap handling
    for i in %w[HUP INT QUIT TERM]
      if trap(i, "SIG_IGN") != 0 then
        trap(i) { close }
      end
    end
  end

  def close
    Curses.close_screen
    print "Have a very merry Christmas!\n"
    exit 0
  end

  def draw
    @window.clear
    @flakes.each do |flake|
      @window.setpos flake.y, flake.x
      @window.addch flake.symbol
    end
    @window.refresh
  end

  def move
    @flakes.count.times do |i|
      if @flakes[i].y > Curses.lines
        @flakes[i] = Flake.new
      end
      flake=@flakes[i]
      flake.y = flake.y + flake.vert_speed
      flake.x = flake.x + flake.horz_speed
    end
  end


  def make_it_snow
      while true
        draw
        move
        sleep SLEEP_TIME
      end
  end

end

RedSnow.new.make_it_snow
