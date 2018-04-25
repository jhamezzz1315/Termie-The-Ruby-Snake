class Node
  attr_accessor :next, :x_value, :y_value
 
  def initialize(x_value, y_value)
  	@x_value = x_value
    @y_value = y_value
    @next  = nil
  end

  def change_x(x_value)
  	@x_value = x_value
  end

  def change_y(y_value)
  	@y_value = y_value
  end
 
  def to_s
    puts "Node with x_value: #{@x_value}"
    "Node with y_value: #{@y_value}"
  end
end