require 'gosu'
require_relative 'node'
require_relative 'linked_list'

class GameWindow < Gosu::Window

	def initialize(width=800, height=600, fullscreen=false,linkedList)
    super
    self.caption = 'Hello Movement'
    @linkedList = linkedList
   	@snake_color = 0xff_ff0000
   	@food_color = 0xff_ffff00
   	@left_direction = false
   	@right_direction = true
   	@up_direction = false
   	@down_direction =false
    @draws = 0
    @buttons_down = 0
  end

  def update_list(x_increment, y_increment)
    @linkedList.update_list(x_increment, y_increment)
  	@latest_x_increment = x_increment
  	@latest_y_increment = y_increment
  end

  def update
   	@linkedList.update_list(@up_direction, @down_direction, @right_direction, @left_direction)
 	end

 	def button_down(id)
 		if id == Gosu::KbUp and !@down_direction 
 			@up_direction = true
 			@right_direction = false
 			@left_direction = false
 		elsif id == Gosu::KbDown and !@up_direction
 			@down_direction = true
 			@right_direction = false
 			@left_direction = false
 		elsif id == Gosu::KbRight and !@left_direction
 			@right_direction = true
 			@up_direction = false
 			@down_direction = false
 		elsif id == Gosu::KbLeft and !@right_direction
 			@left_direction = true
 			@up_direction = false
 			@down_direction = false
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

  end

  def draw
    	
  end
end

window = GameWindow.new
window.show