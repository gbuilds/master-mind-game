# check if there is a win or a loss
# win => 4 direct hits
# lose => 12 rounds with no win
# create a game loop and end the loop if there is a loser/winner


class Game
  def initialize(player)
    @playing = true
    @turn_count = 1
    @player = Player.new(player)
    @computer_player = Player.new("Computer Test Dumbie")
    @master_code = Array.new(4, :empty)
    @guess = Array.new(4, :empty)
    @colors = ["r", "b", "y", "o", "g", "w"]
  end
  
  def set_the_board
    @master_code = @colors.sample(4)
  end
  
  def turn
    while @playing
      @guess = @player.make_guess
      compare
      check_for_victory
      @turn_count += 1
      check_for_defeat
    end
  end
  
  def compare
    direct_hits = 0
    indirect_hits = 0
    @master_code.each_with_index do |piece, index|
      if piece == @guess[index]
        direct_hits += 1
      end
    end
    nonmatches = @master_code - @guess
    indirect_hits = 4 - (direct_hits + nonmatches.size)
    puts "guessed '#{@guess.join}', direct hits: #{direct_hits}, indirect hits: #{indirect_hits}"
  end
  
  def check_for_victory
    victorious = false
    if @master_code == @guess
      puts "VICTORIOUS! #{@player.name} cracked the code and is the winner."
      victorious = true
      @playing = false
    end
    victorious
  end
  
  def check_for_defeat
    defeat = false
    if @turn_count == 13
      defeat = true
      @playing = false
      puts "YOU LOSE. #{@player.name} could not crack the code in time!!"
    end
    defeat
  end
  
  def help
    puts "Playing MasterMind"
    puts "Enter letters for colors..."
    puts "r = red, b = blue, y = yellow, g = green, w = white, o = orange"
    puts "e.g. 'brbr' => blue, red, blue, red"
  end
  
  def give_up
    p @master_code
  end
  
end

class Player
  attr_accessor :name
  
  def initialize(name)
    @name = name
  end
    
  def make_guess
    good_guess = false
    while good_guess == false
      guess = gets.chomp
      good_guess = true
      if guess.length != 4
        puts "You did not guess 4 letters"
        good_guess = false
      end
      unless guess =~ /[rybgwo]{4}/
        puts "Guess letters 'rbygwo'. OR ELSE."
        good_guess = false
      end
    end
    guess = guess.split("")
  end
  
  
end

newgame = Game.new("Gordie")
newgame.set_the_board
newgame.help
newgame.turn