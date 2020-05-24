# CLASS: PlayerInterface
#
# Author: Risto Zimbakov, 7841204
#
# REMARKS: implements a the interface for both human player and comp player
# as they have similarities and it helps store them in the same array without the need of downcasting
# because ruby just polymorphically calls the right canAnswer when it pulls the player
# out of the array
#-----------------------------------------
class PlayerInterface
  def PlayerInterface.new(*args)
    if self == PlayerInterface
      raise "cant make instance of #{self}"
    else
      super
    end
  end

  def initialize()
    @numPlayers = nil
    @indexCurr = nil
    @listOfSus = Array.new(0)
    @listOfPlace = Array.new(0)
    @listOfWpn = Array.new(0)
    @MyCards = Array.new(0)
  end

  #------------------------------------------------------
  # setup(numPlayers,indexCurr,listOfSus,listOfPlace,listOfWpn)
  #
  # PURPOSE:   sets up each player with everything they need to know about the game
  # PARAMETERS:
  #     numPlayers: how many players are playing
  #     indexCurr: what player index they are
  #     listOfSus: the suspects in the game
  #     listOfPlace: the places in the game
  #     listOfWpn: the weapons used in the game
  # Returns: none
  #------------------------------------------------------
  def setup(numPlayers,indexCurr,listOfSus,listOfPlace,listOfWpn)
    @numPlayers = numPlayers
    @indexCurr = indexCurr
    @listOfSus = listOfSus.dup
    @listOfPlace = listOfPlace.dup
    @listOfWpn = listOfWpn.dup
  end

  #------------------------------------------------------
  # setCard(newCard)
  #
  # PURPOSE:   ensure each player has one of these methods but not concrete in interface
  # PARAMETERS:
  #     newCard
  # Returns: none
  #------------------------------------------------------
  def setCard(newCard)
    raise "setCard was not implemented in #{self}"
  end

  #------------------------------------------------------
  # canAnswer(guessPlayerI,guessG)
  #
  # PURPOSE:   ensure each player has one of these methods but not concrete in interface
  # PARAMETERS:
  #     guessPlayerI
  #     guessG
  # Returns: none
  #------------------------------------------------------
  def canAnswer(guessPlayerI,guessG)
    raise "canAnswer was not implemented in #{self}"
  end

  #------------------------------------------------------
  # getGuess
  #
  # PURPOSE:   ensure each player has one of these methods but not concrete in interface
  # PARAMETERS:
  #     none
  # Returns: none
  #------------------------------------------------------
  def getGuess
    raise "getGuess was not implemented in #{self}"
  end

  #------------------------------------------------------
    # receiveInfo(pIndexI,cardC)
    #
    # PURPOSE:   ensure each player has one of these methods but not concrete in interface
    # PARAMETERS:
    #     pIndexI
    #     cardC
    # Returns: none
    #------------------------------------------------------
  def receiveInfo(pIndexI,cardC)
    raise "receiveInfo was not implemented in #{self}"
  end

end