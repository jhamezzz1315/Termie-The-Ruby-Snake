class Node
  attr_accessor :next, :x_value, :y_value
 
  def initialize(x_value, y_value)
  	@x_value = x_value
    @y_value = y_value
    @next  = nil
  end
 
  def to_s
    "Node with value: #{@x_value}"
  end
end