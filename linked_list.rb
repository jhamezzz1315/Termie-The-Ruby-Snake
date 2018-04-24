require_relative 'node'

class LinkedList
  def initialize
    @head = nil
  end
 
  def append(x_value, y_value)
    if @head
      find_tail.next = Node.new(x_value, y_value)
    else
      @head = Node.new(x_value, y_value)
    end
  end
 
  def find_tail
    node = @head
 
    return node if !node.next 
    return node if !node.next while (node = node.next)
  end

  def update_list(up_direction, down_direction, right_direction, left_direction)
  	cur_node = @head
  	next_node = cur_node.next

  	while next_node != nil
  		next_node.x_value = cur_node.x_value
  		next_node.y_value = cur_node.y_value
  		cur_node = next_node
  		next_node = next_node.next
  	end

  	if up_direction
  		@head.y_value -= 10
  	elsif down_direction
  		@head.y_value += 10
  	elsif right_direction
  		@head.x_value += 10
  	elsif left_direction
  		@head.x_value -= 10
  	end
  end
end
