require_relative 'node'

class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
    append(400, 300)
    append(380, 300)
    append(360, 300)
  end
 
  def append(x_value, y_value)
    if @head
      find_tail.next = Node.new(x_value, y_value)
    else
      @head = Node.new(x_value, y_value)
    end
    puts "Added"
  end

  def print
    node = @head
    puts node
 
    while (node = node.next)
      puts node
    end
  end

  def append_last(up_direction, down_direction, right_direction, left_direction)
    node = find_tail

    if up_direction
      append(node.x_value, node.y_value + 20)
    elsif down_direction
      append(node.x_value, node.y_value - 20)
    elsif right_direction
      append(node.x_value - 20, node.y_value)
    elsif left_direction
      append(node.x_value + 20, node.y_value)
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

  	while next_node do
      puts "Current node x: #{cur_node.x_value}"
      puts "Next node x: #{next_node.x_value}"
  		next_node.change_x(cur_node.x_value)
  		next_node.change_y(cur_node.y_value)
  		cur_node = next_node
  		next_node = next_node.next
      puts "After change Current node x: #{cur_node.x_value}"
      # puts "After change Next node x: #{next_node.x_value}"
  	end

    if up_direction
      @head.y_value -= 20
    elsif down_direction
      @head.y_value += 20
    elsif right_direction
      @head.x_value += 20
    elsif left_direction
      @head.x_value -= 20
    end

  	
  end

end
