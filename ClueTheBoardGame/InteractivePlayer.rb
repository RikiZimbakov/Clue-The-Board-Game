# CLASS: InteractivePlayer
#
# Author: Risto Zimbakov, 7841204
#
# REMARKS: The human player class should prompt the user for information. For instance, the method canAnswer
# should show the human player the current guess and the current index i, show the player
# the cards they have that they can show player i, and then ask which card they wish to show.
# The program is not responsible for managing the human player’s deduction
#-----------------------------------------
require_relative "PlayerInterface"

class InteractivePlayer < PlayerInterface
  def initialize()
    super
  end

  #------------------------------------------------------
  # setCard(newCard)
  #
  # PURPOSE:    To makesure the player knows what cards they have been dealt
  # PARAMETERS:
  #     newCard which is of type card that represents a card they havent seen before
  # Returns: none
  #------------------------------------------------------
  def setCard(newCard)
    @MyCards << newCard
    puts("You have recieved the Card #{newCard.value}")
  end

  #------------------------------------------------------
  # canAnswer(guessPlayerI,guessG)
  #
  # PURPOSE:    To check if the interactive player can respond to a guess made by another player
  # PARAMETERS:
  #     guessPlayerI: which is the index of the player that is guessing
  #     guessG: is the guess made by the other player     
  # Returns: card disproving guess and shows to player
  #------------------------------------------------------
  def canAnswer(guessPlayerI,guessG)
    print("Player #{guessPlayerI} asked you about Suggestion: #{guessG.person.value} in the #{guessG.place.value} with the #{guessG.weapon.value}")
    returnMe = nil
    @answerArray = Array.new(0) #will contain an answer if there is one or many
    n = @MyCards.length
    n.times{ |i|
      if @MyCards[i].value == guessG.weapon.value ||
      @MyCards[i].value == guessG.person.value ||
      @MyCards[i].value == guessG.place.value
        @answerArray << @MyCards[i]
      end
    }
    if @answerArray.length == 0
      puts(", but you couldn't answer")
    else if @answerArray.length > 1
        puts(". Which do you show?")
        n = @answerArray.length
        n.times{ |i|
          puts("#{i}: #{@answerArray[i].value}")
        }
        puts("Which do you pick?")
        while returnMe == nil
          check = gets
          if(!check.match(/^(\d)+$/)) #this checks if user typed in a number
            puts("invalid answer! pick again")
          else
            n = check.to_i #only converts to integer after it knows number was typed
            if n > @answerArray.length-1
              puts("invalid number! pick again")
            else
              returnMe = @answerArray[n] #simply returns the answer user picked
              puts("#{@answerArray[n].value}, you showed it")
            end

          end
        end
      else
        puts(", you only have one card, #{@answerArray[0].value} showed it to them")
        returnMe = @answerArray[0] #only have one answer does not give user option because there is none

      end
    end

    returnMe
  end

  #------------------------------------------------------
  # getGuess
  #
  # PURPOSE:   returns a guess that the human player wants to make
  # PARAMETERS:
  #     none   
  # Returns: valid new guess made by human player
  #------------------------------------------------------
  def getGuess
    puts("it is your turn.")
    person = nil
    place = nil
    weapon = nil
    accusation = nil

    #simply shows user all the options that can be made
    puts("which person do you want to suggest?")
    n = @listOfSus.length
    n.times{ |i|
      puts("#{i}: #{@listOfSus[i].value}")
    }
    while person == nil
      check = gets
      if(!check.match(/^(\d)+$/)) #again just some boundary checking to make sure answer is valid
        puts("Invalid answer. Try Again") 
      else
        n = check.to_i
        if n > @listOfSus.length-1 #ensures even if postive number is typed that it is within range
          puts("Invalid answer. Try Again")
        else
          person = @listOfSus[n]
          puts("you picked the #{@listOfSus[n].value} card")
        end

      end
    end

    puts("which location do you want to suggest?")
    n = @listOfPlace.length
    n.times{ |i|
      puts("#{i}: #{@listOfPlace[i].value}")
    }
    while place == nil
      check = gets
      if(!check.match(/^(\d)+$/))
        puts("Invalid answer. Try Again")
      else
        n = check.to_i
        if n > @listOfPlace.length-1
          puts("Invalid answer. Try Again")
        else
          place = @listOfPlace[n]
          puts("you picked the #{@listOfPlace[n].value} card")
        end

      end
    end

    puts("which weapon do you want to suggest?")
    n = @listOfWpn.length
    n.times{ |i|
      puts("#{i}: #{@listOfWpn[i].value}")
    }
    while weapon == nil
      check = gets
      if(!check.match(/^(\d)+$/))
        puts("Invalid answer. Try Again")
      else
        n = check.to_i
        if n > @listOfWpn.length-1 
          puts("Invalid answer. Try Again")
        else
          weapon = @listOfWpn[n]
          puts("you picked the #{@listOfWpn[n].value} card")
        end

      end
    end

    puts("Is this an accusation (Y/[N])?")
    while(accusation == nil)
      check = gets.chomp.to_s
      check.downcase!
      if check[0,1].include?("n") #only accepts if user puts first character as n or y(capital or not)
        accusation = false
      else if check[0,1].include?("y")
          accusation = true
        else
          puts("Invalid answer. Try Again")
        end
      end
    end
    myGuess = Guess.new(person,place,weapon,accusation)

    myGuess
  end

  #------------------------------------------------------
  # receiveInfo(otherPlayer,cardC)
  #
  # PURPOSE:   Tells the human player what player refuted their suggestion
  # and with what card otherwise it tells the player noone could refute their card
  # PARAMETERS:
  #     otherPlayer: the computer player showing us the card
  #     cardC: the card being shown the disprove the guess
  # Returns: none
  #------------------------------------------------------
  def receiveInfo(otherPlayer,cardC)
    if otherPlayer != -1 && cardC != nil
      puts("Player #{otherPlayer} refuted your suggestion by showing you the #{cardC.value} card")

    else
      puts("No one could refute your suggestion")

    end
  end
end