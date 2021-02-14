require_relative "Print.rb"
require_relative "Messages.rb"
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