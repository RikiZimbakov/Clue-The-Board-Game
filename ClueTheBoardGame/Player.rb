# CLASS: Player
#
# Author: Risto Zimbakov, 7841204
#
# REMARKS: implements a computer player. The players should both obey
# the requirements that it makes reasonable guesses (i.e., it never makes
# guesses about cards it is already aware of, if possible). To ensure that
# the computer player is making reasonable guesses, it must pass the ruby
# unit test file that is provided to you.
#-----------------------------------------
require_relative "PlayerInterface"

class Player < PlayerInterface
  
  def initialize()
    super
    @luckyGuess = false #AI will recognize if it made a lucky guess and found answer
  end

  #------------------------------------------------------
  # setCard(newCard)
  #
  # PURPOSE:    takes in card then computer player checks off card as being seen before
  #             so does not use card in guess
  # PARAMETERS:
  #     newCard which is of type card that represents a card they havent seen before
  # Returns: none
  #------------------------------------------------------  
  def setCard(newCard)
    @MyCards << newCard
    
    #checks what type of card it is and deletes it from list 
    #does this for each type of card
    if newCard.type == :person
      n = @listOfSus.length
      n.times{ |i|
        if @listOfSus[i] == newCard
          @listOfSus.delete_at(i)
        end
      }
    else if newCard.type == :place
        n = @listOfPlace.length
        n.times{ |i|
          if @listOfPlace[i] == newCard
            @listOfPlace.delete_at(i)
          end
        }
      else if newCard.type == :weapon
          n = @listOfWpn.length
          n.times{ |i|
            if @listOfWpn[i] == newCard
              @listOfWpn.delete_at(i)
            end
          }
        end

      end

    end

  end

  #------------------------------------------------------
  # checkSus
  #
  # PURPOSE:   Was a helper method used for debugging to see why number of suspects
  #            wasnt changing
  # PARAMETERS:
  #     none   
  # Returns: none
  #------------------------------------------------------
  def checkSus
    m = @listOfSus.length
    puts(m)
    m.times{ |i|
      puts(@listOfSus[i].value)
    }
  end

  #------------------------------------------------------
  # canAnswer(guessPlayerI,guessG)
  #
  # PURPOSE:    To check if the computer player can answer a guess based on what cards they have
  # PARAMETERS:
  #     guessPlayerI: which is the index of the player that is guessing
  #     guessG: is the guess made by the other player     
  # Returns: card disproving guess and shows to player
  #------------------------------------------------------
  def canAnswer(guessPlayerI,guessG)
    
    returnMe = nil
    @answerArray = Array.new #new array filled with answers to disprove opponents guess
    
    n = @MyCards.length
    n.times{ |i|
      if @MyCards[i] == guessG.weapon || #checks to see if match
      @MyCards[i] == guessG.person ||
      @MyCards[i] == guessG.place
        @answerArray << @MyCards[i]
      end
    }
    if @answerArray == nil
      puts("Player #{@indexCurr} cannot answer")
    else if @answerArray.length >= 1
        returnMe = @answerArray[0] #always returns first answer found
      end
    end

    returnMe
    
  end

  #------------------------------------------------------
  # getGuess
  #
  # PURPOSE:   looks at all available options and makes a random guess of all the cards
  # remaining as to keep other opponents guessing while if know the answer to make accusation instead
  # PARAMETERS:
  #     none   
  # Returns: valid new guess made by computer player
  #------------------------------------------------------
  def getGuess

    if(@listOfSus.length == 1 &&
    @listOfPlace.length == 1 &&
    @listOfWpn.length == 1 )     #can only be one answer
      myGuess = Guess.new(@listOfSus[0],@listOfPlace[0],@listOfWpn[0],true)
    else if @luckyGuess == false #keep on guessing
        @listOfSus.shuffle!
        @listOfPlace.shuffle!
        @listOfWpn.shuffle!
        myGuess = Guess.new(@listOfSus[0],@listOfPlace[0],@listOfWpn[0],false)
        
      else #only make it here if lucky guess and found answer
        myGuess = Guess.new(@listOfSus[0],@listOfPlace[0],@listOfWpn[0],true) #makes exact same guess because it luckily guessed the right answer so computer wins
      end
    end
   
    myGuess #returns the guess
  end

  #------------------------------------------------------
  # receiveInfo(otherPlayer,cardC)
  #
  # PURPOSE:   Tells the comp player what player refuted their suggestion and it deletes card
  # PARAMETERS:
  #     otherPlayer: the other player showing us the card
  #     cardC: the card being shown to disprove the guess
  # Returns: none
  #------------------------------------------------------
  def receiveInfo(otherPlayer,cardC)
    
    if otherPlayer != -1 && cardC != nil #only valid player and card
      if cardC.type == :person #has to check each type to see which deck to check off from
        n = @listOfSus.length
        n.times{ |i|
          if @listOfSus[i].value == cardC.value
            @listOfSus.delete_at(i)
            break
          end
        }
      else if cardC.type == :place
          n = @listOfPlace.length
          n.times{ |i|
            if @listOfPlace[i].value == cardC.value
              @listOfPlace.delete_at(i)
              break
            end
          }
        else if cardC.type == :weapon
            n = @listOfWpn.length
            n.times{ |i|
              if @listOfWpn[i].value == cardC.value
                @listOfWpn.delete_at(i)
                break
              end
            }
          end

        end

      end
    else
      @luckyGuess = true #it knows it can win next turn only if human player doesnt know whats happening though

    end

  end

end