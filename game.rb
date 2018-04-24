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

	def initialize(width=800, height=600, fullscreen=false, update_interval = 50 )
    super
    self.caption = 'Hello Movement'
    @linkedList = LinkedList.new
   	@left_direction = false
   	@right_direction = true
   	@up_direction = false
   	@down_direction =false
    @left_direction_paused = false
    @right_direction_paused = false
    @up_direction_paused = false
    @down_direction_paused =false
    @paused = false
    @buttons_down = 0
  end

  def update
   	@linkedList.update_list(@up_direction, @down_direction, @right_direction, @left_direction)
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

	def needs_redraw?
    @buttons_down > 0 || @down_direction || @up_direction || @left_direction || @right_direction
  end

  def check_collision
    node = @linkedList.head

    if node.x_value < LEFT_SIDE_BOUND or node.x_value >= RIGHT_SIDE_BOUND or 
      node.y_value <= UPPER_BOUND or node.y_value >= LOWER_BOUND
      close
    end
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
      self.draw_rect(x, y, RECT_SIZE, RECT_SIZE, BORDER_COLOR, 1, :default)
      x -= RECT_SIZE
    end

    node = @linkedList.head

    while node != nil do
      self.draw_rect(node.x_value, node.y_value, RECT_SIZE, RECT_SIZE, SNAKE_COLOR, 1, :default)
      node = node.next
    end

  end
end

window = GameWindow.new
window.show