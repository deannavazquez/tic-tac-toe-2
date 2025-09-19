# Controls flow and state of game

class Game
  def initialize
    welcome_message
    # @current_player = 0
  end

  def welcome_message # rubocop:disable Metrics/MethodLength
    instructions = <<~TEXT
      ==============================
             Welcome to Tic Tac Toe
      ==============================

      Players:
       - Player 1 is X
       - Player 2 is O

      How to play:
       - The board is a 3x3 grid (rows and columns numbered 0–2).
       - On your turn, enter a move in the format: row column
         Example: '1 2' means row 1, column 2.
       - A move is valid only if the chosen square is empty.
       - First player to line up 3 symbols in a row, column,
         or diagonal wins.
       - If the board fills with no winner, it’s a draw.

      Board layout (row and column numbers shown):
             0   1   2
          0    |   |
            ---+---+---
          1    |   |
            ---+---+---
          2    |   |

      Let’s begin! Player 1 (X) goes first.
    TEXT

    puts instructions
  end
end
