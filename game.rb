require 'gosu'
require_relative 'node'
require_relative 'linked_list'

class GameWindow < Gosu::Window
  UPPER_BOUND = 20
  LOWER_BOUND = 580
  LEFT_SIDE_BOUND = 20
  RIGHT_SIDE_BOUND = 780
  BORDER_COLOR = 0xff_0000ff
  SNAKE_COLOR = 0xff_ff0000
  FOOD_COLOR = 0xff_ffff00
  RECT_SIZE = 20

	def initialize(width=800, height=600, fullscreen=false, update_interval = 100 )
    super
    self.caption = 'TERMIE THE RUBY SNAKE'
    @linkedList = LinkedList.new

    create_list

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
    @buttons_down = 0
    @level = 1
    @score = 0
    @font = Gosu::Font.new(20)

    place_of_food
  end

  #initialize nodes of out current linked list
  def create_list
    @linkedList.append(400, 300)
    @linkedList.append(380, 300)
    @linkedList.append(360, 300)
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

 	def button_down(id)
 		if id == Gosu::KB_W and !@down_direction 
 			@up_direction = true
 			@right_direction = false
 			@left_direction = false
 		elsif id == Gosu::KB_S and !@up_direction
 			@down_direction = true
 			@right_direction = false
 			@left_direction = false
 		elsif id == Gosu::KB_D and !@left_direction
 			@right_direction = true
 			@up_direction = false
 			@down_direction = false
 		elsif id == Gosu::KB_A and !@right_direction
 			@left_direction = true
 			@up_direction = false
 			@down_direction = false
    elsif id == Gosu::KB_Q
      close
    elsif id == Gosu::KB_SPACE
      toggle_pause
 		end
 		@buttons_down += 1
 	end

  def button_up(id)
	 @buttons_down -= 1
  end

  #overriding needs_redraw? in order to force the window to update
	def needs_redraw?
    @buttons_down > 0 || @down_direction || @up_direction || @left_direction || @right_direction
  end

  def check_collision
    node = @linkedList.head

    if node.x_value < LEFT_SIDE_BOUND or node.x_value >= RIGHT_SIDE_BOUND or 
      node.y_value <= UPPER_BOUND or node.y_value >= LOWER_BOUND or @linkedList.collide
        game_over
        close
    elsif (node.x_value >= @food_x_value and node.x_value <= @food_x_value + RECT_SIZE) 
      if (node.y_value >= @food_y_value and node.y_value <= @food_y_value + RECT_SIZE) or 
          (node.y_value + RECT_SIZE >= @food_y_value and node.y_value <= @food_y_value + RECT_SIZE)
            @score += 1

            if (@score / 10) == @level
              @level += 1
              self.update_interval -= 10  
            end
          
            @linkedList.append_last(@up_direction, @down_direction, @right_direction, @left_direction)
            place_of_food 
      end
    end

  end

  def place_of_food
    @food_x_value = LEFT_SIDE_BOUND + rand(RIGHT_SIDE_BOUND - LEFT_SIDE_BOUND - RECT_SIZE)
    @food_y_value = UPPER_BOUND + RECT_SIZE + rand(LOWER_BOUND - UPPER_BOUND - (2*RECT_SIZE))

    temp = @food_x_value % 10
    @food_x_value -= temp
    temp = @food_y_value % 10
    @food_y_value -= temp
  end

  def game_over
    puts "Game Over"
    puts "Level reached before game over is #{@level}"
    puts "Score achieved before game over is #{@score}"
  end

  def draw
    x = 0
    y = UPPER_BOUND

    while y < LOWER_BOUND do 
      self.draw_rect(x, y, RECT_SIZE, RECT_SIZE, BORDER_COLOR, 1, :additive)
      y += RECT_SIZE
    end

    while x < RIGHT_SIDE_BOUND do
      self.draw_rect(x, y, RECT_SIZE, RECT_SIZE, BORDER_COLOR, 1, :additive)
      x += RECT_SIZE
    end

    while y > UPPER_BOUND do 
      self.draw_rect(x, y, RECT_SIZE, RECT_SIZE, BORDER_COLOR, 1, :additive)
      y -= RECT_SIZE
    end

    while x >= LEFT_SIDE_BOUND do
      self.draw_rect(x, y, RECT_SIZE, RECT_SIZE, BORDER_COLOR, 1, :additive)
      x -= RECT_SIZE
    end

    node = @linkedList.head

    while node != nil do
      self.draw_rect(node.x_value, node.y_value, RECT_SIZE, RECT_SIZE, SNAKE_COLOR, 1, :default)
      node = node.next
    end

    self.draw_rect(@food_x_value, @food_y_value, RECT_SIZE, RECT_SIZE, FOOD_COLOR, 1, :default)

    @font.draw("[q] quit [space] pause",0,0, 1)
    @font.draw("TERMIE THE RUBY SNAKE", 300, 0, 1, 1, 1,0xff_00ff00)
    @font.draw("Level: #{@level} Score: #{@score}", 600, 0, 1, 1, 1, 0xff_00ffff)

  end
end

window = GameWindow.new
window.show