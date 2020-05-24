# CLASS: Card
#
# Author: Risto Zimbakov, 7841204
#
# REMARKS: a card is one of the cards of the game.
# It has two fields: a type and a value.
#
#-----------------------------------------
class Card
  
  attr_reader:type
  attr_reader:value
  
  def initialize(type,value)
    @type = type
    @value = value
  end
end