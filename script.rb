# MODULES
module Print
  def slow_print(msg, time)
    msg.each_char do |c|
      print c
      sleep(time)
    end
  end
end
module Messages
  def head
    "\nWelcome to a Command Line\n
   TIC\n      TAC\n         TOE
  \nExpeeeeeeeeeerience!\n"
  end
  def dl_msg
    "\nDownloading content..."
  end
  def flag
    "\n🏁"
  end
  def dl_complete
    "\nDownload complete!\n"
  end
  def pO_enter
    "\nEnter player O (noughts) name: "
  end
  def pX_enter
    "\nEnter player X (crosses) name: "
  end
  def game_wiki1
    "\nTic-tac-toe is a game for two players, X and O, \nwho take turns marking the spaces in a 3x3 grid.\n" 
  end
  def game_wiki2
    "\nThe player who succeeds in placing three of their marks "
  end
  def game_wiki3
    "in a diagonal, horizontal, or vertical row "
  end
  def game_wiki4
    "is the winner.\n"
  end
  def instruction
    "\nMark your space by typing the row letter followed by the column number like so: "
  end
  def lets_play1
    "\nIt's a simple game isn't it? 🙃\n"
  end
  def lets_play2
    "\nWell, grab your opponent and let's play!!!\n"
  end
  def mark_space
    "\nMark your space: "
  end
end

# CLASSES
class Game
  include Print, Messages
  attr_reader :finished, :allowed_pos
  def initialize
    @board = [["_", "_", "_"], ["_", "_", "_"], ["_", "_", "_"]]
    @allowed_pos = ["a1", "a2", "a3", "b1", "b2", "b3", "c1", "c2", "c3"]
    @finished = false
    @tied = false
    @winner = ""
  end
  def draw_board
    slow_print("\n  1 2 3\nA #{@board[0][0]}\|#{@board[0][1]}\|#{@board[0][2]}\nB #{@board[1][0]}\|#{@board[1][1]}\|#{@board[1][2]}\nC #{@board[2][0]}\|#{@board[2][1]}\|#{@board[2][2]}\n", 0.02)
  end
  def play(shape)
    slow_print(mark_space, 0.05)
    new_pos_O = gets.downcase.chomp
    row_col = row_col(new_pos_O)
    if valid_pos?(new_pos_O) && space_not_taken?(row_col)
      insert(row_col, shape)
    elsif valid_pos?(new_pos_O) && space_taken?(row_col)
      retry_pos_taken(shape)
    else
      retry_pos_wrong(shape)
    end
  end
  def valid_pos?(input)
    @allowed_pos.include?(input)
  end
  def row_col(input)
    col = input[1].to_i - 1
    if input[0] == "a"
      row = 0
    elsif input[0] == "b"
      row = 1
    elsif input[0] == "c"
      row = 2
    end
    [row, col]
  end
  def space_taken?(row_col)
    @board[row_col[0]][row_col[1]] == "O" || @board[row_col[0]][row_col[1]] == "X"
  end
  def space_not_taken?(row_col)
    !(@board[row_col[0]][row_col[1]] == "O" || @board[row_col[0]][row_col[1]] == "X")
  end
  def insert(row_col, shape)
    @board[row_col[0]][row_col[1]] = shape
  end
  def retry_pos_taken(shape)
    slow_print("\nThat space is already taken. Please try again.\n", 0.05)
    sleep(0.5)
    draw_board
    play(shape)
  end
  def retry_pos_wrong(shape)
    slow_print("\nThat's an invalid space. Please try again.\n", 0.05)
    sleep(0.5)
    draw_board
    play(shape)
  end
  def finished?
    combos = []
    combos.push @board[0][0] + @board[0][1] + @board[0][2]
    combos.push @board[1][0] + @board[1][1] + @board[1][2]
    combos.push @board[2][0] + @board[2][1] + @board[2][2]

    combos.push @board[0][0] + @board[1][0] + @board[2][0]
    combos.push @board[0][1] + @board[1][1] + @board[2][1]
    combos.push @board[0][2] + @board[1][2] + @board[2][2]

    combos.push @board[0][0] + @board[1][1] + @board[2][2]
    combos.push @board[2][0] + @board[1][1] + @board[0][2]
    if combos.include?("OOO")
      @finished = true
    elsif combos.include?("XXX")
      @finished = true
    end
    @finished
  end
  def space_left?
    @board.any? do |row|
      row.include?("_")
    end
  end
  def announce_winner(name)
    draw_board
    sleep(0.5)
    slow_print("\nCongratulations! ", 0.05)
    sleep(0.5)
    slow_print("#{name} is the winner!\n", 0.05)
    sleep(0.5)
    slow_print("\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n🥳\n", 0.05)
    slow_print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n", 0.05)
  end
  def announce_tie
    draw_board
    sleep(1)
    slow_print("\nShiiieeeeeeeeeeet...,\n", 0.05)
    sleep(1)
    slow_print("\nissa draw my g..", 0.05)
    sleep(1)
    @finished = true
  end
end
class Player
  attr_reader :name, :shape
  def initialize(name, shape)
    @name = name
    @shape = shape
  end
end

include Print, Messages

# PROGRAM
# Intro Messages
slow_print(head, 0.05)
sleep(1)
slow_print(dl_msg, 0.05)
5.times do
  slow_print(flag, 0.5)
end
sleep(1)
slow_print(dl_complete, 0.05)
sleep(1)
slow_print(game_wiki1, 0.05)
sleep(0.5)
slow_print(game_wiki2, 0.05)
sleep(0.5)
slow_print(game_wiki3, 0.05)
sleep(0.5)
slow_print(game_wiki4, 0.05)
sleep(1)

slow_print(lets_play1, 0.05)
sleep(1)
slow_print(lets_play2, 0.05)
sleep(1)

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

# MESSAGES
pO_turn = "\n#{pO.name}, it's your turn! "
pX_turn = "\n#{pX.name}, it's your turn! "

# Create game object
game = Game.new
sleep(0.5)

# Print instruction
slow_print(instruction, 0.05)
sleep(0.5)
slow_print("A1\n\n", 0.5)
sleep(1)

while game.finished? == false
  game.draw_board
  # sleep(0.5)
  slow_print(pO_turn, 0.05)
  game.play(pO.shape)
  if game.finished? == true
    game.announce_winner(pO.name)
    break
  elsif game.space_left? == false
    game.announce_tie
    break
  end
  game.draw_board
  # sleep(0.5)
  slow_print(pX_turn, 0.05)
  game.play(pX.shape)
  if game.finished? == true
    game.announce_winner(pX.name)
    break
  elsif game.space_left? == false
    game.announce_tie
    break
  end
end
