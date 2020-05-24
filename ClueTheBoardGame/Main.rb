#-----------------------------------------
# NAME    : Risto Zimbakov
# STUDENT NUMBER  : 7841204
# COURSE    : COMP 2150
# INSTRUCTOR  : Prof. Domaratzki (aka card 2)
# ASSIGNMENT  : assignment #4
# QUESTION  : question #1
#
# REMARKS: What is the purpose of this program?
# Purpose of the program is to create a who dunnit game that 
# can be played by a number of players but there is always 
# one human player and multiple computer players
#
#-----------------------------------------
require_relative "Player"
require_relative "Card"
require_relative "Guess"
require_relative "Model"
require_relative "InteractivePlayer"

puts("Welcome to \"whodunnit?\"")
people = [
  Card.new(:person,"Prof. Boyer"),
  Card.new(:person,"Prof. Domaratzki"),
  Card.new(:person,"Prof. Cameron"),
  Card.new(:person,"Prof. Guderian"),
  Card.new(:person,"Prof. Durocher"),
  Card.new(:person,"Prof. Li"),
  Card.new(:person,"Prof. Miller"),
  Card.new(:person,"Prof. Wang"),
  Card.new(:person,"Prof. Bristow")

]

places = [
  Card.new(:place,"COMP 2150 course"),
  Card.new(:place,"COMP 2160 course"),
  Card.new(:place,"COMP 2140 course"),
  Card.new(:place,"COMP 2280 course"),
  Card.new(:place,"COMP 2080 course")
]

weapons = [
  Card.new(:weapon,"midterm"),
  Card.new(:weapon,"final exam"),
  Card.new(:weapon,"assignment"),
  Card.new(:weapon,"lab"),
]

o = Model.new(people,places,weapons)
puts("How many computer opponents would you like?")
numPlayers = gets.chomp.to_i

players = Array.new(numPlayers+1)
(numPlayers).times { |i| players[i] = Player.new() }
players[numPlayers] = InteractivePlayer.new()

puts("Setting up players..")
o.setPlayers(players)
puts("Dealing cards..")
o.setupCards()
puts("Playing...")
o.play()
puts ("Game over")