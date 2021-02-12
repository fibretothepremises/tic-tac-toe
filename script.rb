require "pry"

# MODULES
module Print
  def slow_print(msg, time)
    msg.each_char do |c|
      print c
      sleep(time)
    end
  end
end

include Print

# MESSAGES
head = "\nWelcome to a Command Line\n
   TIC\n      TAC\n         TOE
\nExpeeeeeeeeeerience!\n"
dl_msg = "\nDownloading content..."
flag = "\n🏁"
dl_complete = "\nDownload complete!\n"
pO_enter = "\nEnter player O (noughts) name: "
pX_enter = "\nEnter player X (crosses) name: "
game_wiki1 = "\nTic-tac-toe is a game for two players, X and O, \nwho take turns marking the spaces in a 3x3 grid.\n" 
game_wiki2 = "\nThe player who succeeds in placing three of their marks "
game_wiki3 = "in a diagonal, horizontal, or vertical row "
game_wiki4 = "is the winner.\n"
instruction = "\nMark your space by typing the row letter followed by the column number like so: "
lets_play1 = "\nIt's a simple game isn't it? 🙃\n"
lets_play2 =  "\nWell, grab your opponent and let's play!!!\n"

# CLASSES
class Game
  include Print
  @@board = [["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]]
  @@all_pos = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]
  @@finished = false
  @@tied = false
  @@winner = ""
  

  def insert(position, shape)
    # Check position isn't already taken
    col = position[1].to_i - 1
    if position[0] == "a"
      row = 0
    elsif position[0] == "b"
      row = 1
    elsif position[0] == "c"
      row = 2
    end
    if @@board[row][col] == "O" || @@board[row][col] == "X"
      retry_pos_taken
    else
      @@board[row][col] = shape
      if finished?
        draw_board
        sleep(0.5)
        slow_print("\nCongratulations! ", 0.05)
        sleep(0.5)
        slow_print("#{@@winner} is the winner!\n", 0.05)
        sleep(0.5)
        slow_print("\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n", 0.05)
        slow_print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n", 0.05)
      end
      if space_left? == false
        draw_board
        slow_print("\nShiiieeeeeeeeeeet...,\n", 0.05)
        sleep(1)
        slow_print("\nissa draw my g..", 0.05)
        sleep(1)
        @@finished = true
      end
    end
  end
  def finished?
    combos = []
    combos.push @@board[0][0] + @@board[0][1] + @@board[0][2]
    combos.push @@board[1][0] + @@board[1][1] + @@board[1][2]
    combos.push @@board[2][0] + @@board[2][1] + @@board[2][2]

    combos.push @@board[0][0] + @@board[1][0] + @@board[2][0]
    combos.push @@board[0][1] + @@board[1][1] + @@board[2][1]
    combos.push @@board[0][2] + @@board[1][2] + @@board[2][2]

    combos.push @@board[0][0] + @@board[1][1] + @@board[2][2]
    combos.push @@board[2][0] + @@board[1][1] + @@board[0][2]
    if combos.include?("OOO")
      @@finished = true
      @@winner = @name
    elsif combos.include?("XXX")
      @@finished = true
      @@winner = @name
    end
  end
  def space_left?
    @@board.any? do |row|
      row.include?("_")
    end
  end

  def self.finished
    @@finished
  end
  def draw_board
    slow_print("\n  1 2 3\nA #{@@board[0][0]}\|#{@@board[0][1]}\|#{@@board[0][2]}\nB #{@@board[1][0]}\|#{@@board[1][1]}\|#{@@board[1][2]}\nC #{@@board[2][0]}\|#{@@board[2][1]}\|#{@@board[2][2]}\n", 0.02)
  end
end
class Player < Game
  attr_reader :name
  def initialize(name, shape)
    @name = name
    @shape = shape
  end
  
  def get_new_pos
    slow_print("Mark your space: ", 0.05)
    new_pos = gets.downcase.chomp
    if @@all_pos.include?(new_pos)
      insert(new_pos, @shape)
    else
      retry_pos_wrong
    end
  end
  def retry_pos_wrong
    slow_print("\nThat's an invalid space. Please try again.\n", 0.05)
    sleep(0.5)
    p @shape
    get_new_pos
  end
  def retry_pos_taken
    slow_print("\nThat space is already taken. Please try again.\n", 0.05)
    sleep(0.5)
    draw_board
    get_new_pos
  end
end


# STATES
game_initialized = false

# PROGRAM
# Intro Messages
# slow_print(head, 0.05)
# sleep(1)
# slow_print(dl_msg, 0.05)
# 5.times do
#   slow_print(flag, 0.5)
# end
# sleep(1)
# slow_print(dl_complete, 0.05)
# sleep(1)
# slow_print(game_wiki1, 0.05)
# sleep(0.5)
# slow_print(game_wiki2, 0.05)
# sleep(0.5)
# slow_print(game_wiki3, 0.05)
# sleep(0.5)
# slow_print(game_wiki4, 0.05)
# sleep(1)

# slow_print(lets_play1, 0.05)
# sleep(1)
# slow_print(lets_play2, 0.05)
# sleep(1)

# Get Player O Name
slow_print(pO_enter, 0.05)
playerO_name = gets.chomp.upcase
sleep(0.5)
slow_print("\n#{playerO_name},", 0.05)
sleep(0.5)
slow_print(" welcome and good luck!\n", 0.05)
sleep(0.5)

# Get Player X Name
slow_print(pX_enter, 0.05)
playerX_name = gets.chomp.upcase
sleep(0.5)
slow_print("\n#{playerX_name},", 0.05)
sleep(0.5)
slow_print(" welcome and good luck!\n", 0.05)
sleep(0.5)

# Create player objects
pO = Player.new(playerO_name, "O")
pX = Player.new(playerX_name, "X")

# Create game object
game = Game.new
sleep(0.5)

# Print instruction
# slow_print(instruction, 0.05)
# sleep(0.5)
# slow_print("A1\n\n", 0.5)
# sleep(1)

while Game.finished == false
  game.draw_board
  sleep(0.5)
  slow_print("\n#{pO.name}, it's your turn! \n", 0.05)
  pO.get_new_pos
  if Game.finished == true
    break
  end
  game.draw_board
  sleep(0.5)
  slow_print("\n#{pX.name}, it's your turn! \n", 0.05)
  pX.get_new_pos
end
