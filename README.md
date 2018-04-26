# Termie-The-Ruby-Snake by James Michael K. Kuizon (jkkuizon@up.edu.ph, jameskuizon13@gmail.com)

# This is an technical test for a Software Developer position in Chromedia.
#Ruby version 2.5.0 was used in developing this program.
#Also Gosu a Ruby library has been used in order to create a 2D Snake Game in terminal
#In order to import/install Gosu follow the steps define in this link: https://github.com/gosu/gosu/wiki.
#If you need any further assistance in knowing the methods and variables that I have used please refer to this:http://www.rubydoc.info/github/gosu/gosu/Gosu.

#I have created three ruby files:
#game.rb - this is like the main class  (run this to run the game)
#linked_list.rb - contains the class for creating and manipulating the linked_list
#node.rb - contains the class for the nodes in the linked list

#For every level up the speed increase by 10 ms. I have utilized the update_interval variable in Gosu which is the interval used in order to know if it is time to call the method update of Gosu.
#In updating the linked list I have made a copy of the main linked list so that it will become the basis for the updated linked list. Also I have done it like that to prevent overwriting the main linked list. 
#The insertion method that I have used in the linked list is the inserting at the end. 

#For the terminal run game I have created gamev2.rb and linked_listv2.rb. I have also reuse node.rb. In order to run the game run gamev2.rb.
#There is still a bug on it. I don't know if I can fixed it before the deadline. 