require "curses"
require_relative 'node'
require_relative 'linked_listv2'
include Curses

$level = 1
$score = 0

class GameWindow
  RECT_SIZE = 1

  def initialize
    @win = Curses::Window.new(lines-2, cols,2, 0)
    @win.box("*", "*")
    @win.timeout = 10000
    @win.nodelay = true
    @win.refresh

    @linkedList = LinkedList.new

    create_list

    @upper_bound = 100
    @lower_bound = 100
    @right_side_bound = 100
    @left_side_bound = 100
    @left_direction = false
    @right_direction = true
    @up_direction = false
    @down_direction =false
    @left_direction_paused = false
    @right_direction_paused = false
    @up_direction_paused = false
    @down_direction_paused =false
    @food_x_value = 0
    @food_y_value = 0
    @paused = false    
    @running =  true
    @temp_pressed = ?d
    
    place_of_food
  end

  #initialize nodes of out current linked list
  def create_list
    @linkedList.append(cols/2, lines/2)
    @linkedList.append(cols/2 - 1, lines/2)
    @linkedList.append(cols/2 - 2, lines/2)
    # @linkedList.print
  end

  #method use to copy the current linked list node into a new one in order to be used for updating
  def create_new_list
    temp_linkedList = LinkedList.new
    node = @linkedList.head

    while node
      temp_linkedList.append(node.x_value, node.y_value)
      node = node.next
    end

    return temp_linkedList
  end

  def game_proper
    loop do
      Curses.noecho
      id = @win.getch

      if id == nil
        id = @temp_pressed
      else
        @temp_pressed = id
      end

      button_c(id)
      update
      draw

      if(!@running)
        break
      end
    end    
    @win.close
  end

  def update
    temp_linkedList = create_new_list
    @linkedList.update_list(@up_direction, @down_direction, @right_direction, @left_direction, temp_linkedList)
    check_collision
  end

  def pause
    @left_direction_paused = @left_direction
    @right_direction_paused = @right_direction
    @up_direction_paused = @up_direction
    @down_direction_paused =@down_direction
    @left_direction = false
    @right_direction = false
    @up_direction = false
    @down_direction =false
    @paused = true
  end

  def un_pause
    @left_direction = @left_direction_paused
    @right_direction = @right_direction_paused
    @up_direction = @up_direction_paused
    @down_direction = @down_direction_paused
    @paused = false
  end

  def toggle_pause
    if @paused
      un_pause
    else
      pause
    end
  end

  def button_c(id)
    if (id == ?w or id == ?W)and !@down_direction 
      @up_direction = true
      @right_direction = false
      @left_direction = false
    elsif (id == ?s or id == ?S) and !@up_direction
      @down_direction = true
      @right_direction = false
      @left_direction = false
    elsif (id == ?d or id == ?D) and !@left_direction
      @right_direction = true
      @up_direction = false
      @down_direction = false
    elsif (id == ?a or id == ?A) and !@right_direction
      @left_direction = true
      @up_direction = false
      @down_direction = false
    elsif (id == ?q or id == ?Q)
      @running = false
    elsif id == " "
      toggle_pause
    end
  end

  def check_collision
    node = @linkedList.head

      # if node.x_value < @left_side_bound or node.x_value >= @right_side_bound or 
      #   node.y_value <= @upper_bound or node.y_value >= @lower_bound# or @linkedList.collide
      #     game_over
      #     # win.close
      if (node.x_value >= @food_x_value and node.x_value <= @food_x_value + RECT_SIZE) 
        if (node.y_value >= @food_y_value and node.y_value <= @food_y_value + RECT_SIZE) or 
            (node.y_value + RECT_SIZE >= @food_y_value and node.y_value <= @food_y_value + RECT_SIZE)
              $score += 1

              if ($score / 10) == @level
                $level += 1
                @win.timeout -= 10  
              end
          
              @linkedList.append_last(@up_direction, @down_direction, @right_direction, @left_direction)
              place_of_food 
        end
      end
  end

  def place_of_food
    @food_y_value = rand(lines/2) + 2
    @food_x_value = rand(cols/2) + 1
  end

  def game_over
    puts "Game Over"
    puts "Level reached before game over is #{@level}"
    puts "Score achieved before game over is #{@score}"
  end

  def draw
    start_color
    Curses.clear
    @win.clear
    Curses.refresh
    @win.refresh
    node = @linkedList.head

    init_pair(4,0,1)
    while node != nil do
      @win.attrset(color_pair(4) | A_INVIS)
      @win.setpos(node.y_value, node.x_value)
      @win.addstr(" ")
      node = node.next
      @win.refresh
    end

    init_pair(5, 0, 3)
    @win.attrset(color_pair(5) | A_INVIS)
    @win.setpos(@food_y_value,@food_x_value)
    @win.addstr(" ")
    @win.refresh
  end
end


init_screen
start_color
curs_set(0)
begin
  crmode
  # use lines and cols to know the center of the screen
  # show_message("Hit any key")
  init_pair(1, 7, 0)
  noecho
  attrset(color_pair(1) | A_BOLD)
  setpos(0,0)
  addstr("[q] quit [space] pause")
  init_pair(2, 2, 0)
  attrset(color_pair(2) | A_BOLD)
  setpos(0, cols/2 - 10)
  addstr("TERMIE THE RUBY SNAKE")
  init_pair(3, 5, 0)
  attrset(color_pair(3) | A_BOLD)
  setpos(0, cols/2 + 20)
  addstr("Level: #{$level} Score: #{$score}")
  refresh
  game = GameWindow.new
  game.game_proper 
  refresh
ensure
  close_screen
end