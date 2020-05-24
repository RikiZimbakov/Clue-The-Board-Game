# CLASS: Guess
#
# Author: Risto Zimbakov, 7841204
#
# REMARKS: a guess is made by a player when they want to learn more information about the game.
# A guess consists of three cards, and a boolean variable for whether the guess is a suggestion or
# an accusation. The names of the fields should be "person", "place" and "weapon".
#
#-----------------------------------------

class Guess
  attr_reader :weapon
  attr_reader :person
  attr_reader :place
  attr_reader :accusation
  
  def initialize(person,place,weapon,accusation)
    @person = person
    @place = place
    @weapon = weapon
    @accusation = accusation
  end

  #------------------------------------------------------
  # isAccusation
  #
  # PURPOSE:    simply returns if the guess is an accusation or not
  # PARAMETERS:
  #     none
  # Returns: a boolean indicating whether or not accusation
  #------------------------------------------------------
  def isAccusation()
    @accusation
  end
end