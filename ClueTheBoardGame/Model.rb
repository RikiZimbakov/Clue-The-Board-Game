# CLASS: Model
#
# Author: Risto Zimbakov, 7841204
#
# REMARKS: The model is the portion of the program that stores all of the players, all of the cards, and runs the
# game. The model will give all players a number between 0 and n-1 where n is the total number of
# players. Players are arranged in order 0 through n-1 around the table. That is, after player i's turn, it
# will be player (i+1)%n's turn. The model will create, shuffle and distribute all of the cards to the players, as well as holding the
# three “answer” cards (the who-where-how cards).
#-----------------------------------------

class Model
  
  def initialize(suspectArray,locationArray,weaponArray)
    @suspectArray = suspectArray
    @locationArray = locationArray
    @weaponArray = weaponArray
    @playerArray = nil
  end

  #------------------------------------------------------
  # setPlayers(playerArray)
  #
  # PURPOSE:   Basically sets up the game with players and lets
  # the players know about how many cards there are, what player they are,
  # all the basic setup needed for the players to be ready to play.
  # Also lets the human player know of all the cards available
  # PARAMETERS:
  #     playerArray: How many players will be playing this game
  # Returns: none
  #------------------------------------------------------
  def setPlayers(playerArray)

    @playerArray = playerArray
    n = @playerArray.length
    #loop that gives each player the info they need
    n.times{ |i|
      @playerArray[i].setup(n,i,@suspectArray,@locationArray,@weaponArray)
    }
    
    #simply print methods showing all the cards
    puts("Here are the names of all the suspects:")
    n = @suspectArray.length
    n.times{ |i|
      if i == @suspectArray.length-1
        puts("#{@suspectArray[i].value} ")
      else
        print("#{@suspectArray[i].value}, ")
      end
    }

    puts("Here are all the locations:")
    n = @locationArray.length
    n.times{ |i|
      if i == @locationArray.length-1
        puts("#{@locationArray[i].value} ")
      else
        print("#{@locationArray[i].value}, ")
      end
    }
    puts("Here are all the weapons:")
    n = @weaponArray.length
    n.times{ |i|
      if i == @weaponArray.length-1
        puts("#{@weaponArray[i].value} ")
      else
        print("#{@weaponArray[i].value}, ")
      end
    }

    #this should set up each player
    #so that they know all the information
  end

  #------------------------------------------------------
  # setupCards
  #
  # PURPOSE:   A method setupCards that does all of the setup for cards before a game starts. This method
  # takes no parameters. This method should choose the answer for the game (the criminal, the
  # location and the weapon) and then distribute all remaining cards to the players. Similar to
  # the original board game, cards are distributed to players based on their index (i.e., player 0,
  # then player 1, then player 2, … ) and it is ok if some players receive one more card than
  # other players.
  # PARAMETERS:
  #     playerArray: How many players will be playing this game
  # Returns: none
  #------------------------------------------------------
  def setupCards

    @answerArray = Array.new(0)#creates an array that will store the answers to the game

    @suspectArray.shuffle!
    @answerArray << @suspectArray[0].dup #makes a duplicate just incase we manipulate card in some way
    @suspectArray.delete_at(0)#should remove the element just added to answerArray

    @locationArray.shuffle!
    @answerArray << @locationArray[0].dup
    @locationArray.delete_at(0) #should remove the element just added to answerArray

    @weaponArray.shuffle!
    @answerArray << @weaponArray[0].dup

    @weaponArray.delete_at(0) #should remove the element just added to answerArray

    @dealingArray = @suspectArray + @locationArray + @weaponArray #combines all three decks and deals out to players
    n = @dealingArray.length
    n.times{ |i|
      #puts("im here")
      @playerArray[i % @playerArray.length].setCard(@dealingArray[i])
    } #will distribute all remaining suspect cards to players

  end

  #------------------------------------------------------
  # play
  #
  # PURPOSE:  very important method that is in charge of running the game
  # which includes everything from taking turns to calling all the 
  # appropriate methods while also printing out very important messages along the
  # way. The winners and losers are also decided here
  # PARAMETERS:
  #     none
  # Returns: none
  #------------------------------------------------------
  def play
    gameOver = false #controls the while loop
    curr = 0
    
    @playersInGame = @playerArray.dup #need seperate array of players still in game because once player is removed can still give answers
   
    while(!gameOver)
      puts("Current turn: #{curr}")
      if(@playerArray.length == 1) #edge case if human typed play against zero players
        puts("you tried playing a game with only one person. Shame on you!")
        break
      end

      currGuess = @playersInGame[curr].getGuess #gets the current guess from the player whose turn it is

      if currGuess.isAccusation() #checks if accusation
        puts("Player #{curr}: Accusation: #{currGuess.person.value} in #{currGuess.place.value} with the #{currGuess.weapon.value}")
        if(currGuess.person.value == @answerArray[0].value &&
        currGuess.place.value == @answerArray[1].value &&
        currGuess.weapon.value == @answerArray[2].value) #alll three must be right to win

          puts("Player #{curr} won the game!!")
          gameOver = true
        else
          @playersInGame.delete_at(curr) #remove player from game
          puts("Player #{curr} made a bad accusation and was removed from the game.")

          if @playersInGame.length == 1 #removed one too many players
            puts("Game is over! Only One player remaining.")
            gameOver = true
          end
        end
        
      else #only makes it here if its a suggestion
        puts("Player #{curr}: Suggestion: #{currGuess.person.value} in #{currGuess.place.value} with the #{currGuess.weapon.value}")
        
        #rest is needed to go through all other players and check if they can give an answer
        #note that its mod of the player array NOT playersInGame array because even though player removed from game can still answer
        guessCurr = (curr + 1) % @playerArray.length 
        answer = nil
        while(guessCurr != curr && answer.nil?) #continues on until answer found or back to player whos turn it is
          puts("Asking player #{guessCurr}.")
          answer = @playerArray[guessCurr].canAnswer(curr,currGuess)
          if answer.nil?
            guessCurr = (guessCurr + 1) % @playerArray.length #mod player array because even when removed from game can still make guesses
          end
        end

        if !answer.nil?
          puts("Player #{guessCurr} answered.")
          @playersInGame[curr].receiveInfo(guessCurr,answer)
        else
          puts("No one could answer.")
          @playersInGame[curr].receiveInfo(-1,nil)
        end
      end
      curr = (curr + 1) % @playersInGame.length #mod playersIngame because only have to go through the remaining players
    end

  end

end