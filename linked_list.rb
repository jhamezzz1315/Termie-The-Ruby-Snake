require_relative 'node'

class LinkedList
  attr_accessor :head

  def initialize
    @head = nil
  end
 
  #Append at the tail
  def append(x_value, y_value)
    if @head
      find_tail.next = Node.new(x_value, y_value)
    else
      @head = Node.new(x_value, y_value)
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
 
  #Finding the tail in order to append in the last node
  def find_tail
    node = @head
 
    return node if !node.next 
    return node if !node.next while (node = node.next)
  end

  def update_list(up_direction, down_direction, right_direction, left_direction, temp)
    cur_node = @head.next
    temp_cur_node = temp.head

    while cur_node
      cur_node.x_value = temp_cur_node.x_value
      cur_node.y_value = temp_cur_node.y_value
      cur_node = cur_node.next
      temp_cur_node = temp_cur_node.next
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

  def collide
    node = @head.next

    while node
      return true if @head.x_value == node.x_value and @head.y_value == node.y_value
      node = node.next
    end

    false
  end

end
