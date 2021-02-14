require_relative "Print.rb"
require_relative "Messages.rb"
require_relative "Game.rb"
require_relative "Player.rb"
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
