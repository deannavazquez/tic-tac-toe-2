# Main CLI game loop (entry)
require_relative 'player'

class Game
  attr_accessor :board, :player1, :player2

  def initialize
    welcome_message
    @board = create_board
    initialize_players
    @current_player_index = 0
  end

  def initialize_players
    @player1 = Player.new(1, 'X')
    @player2 = Player.new(2, 'O')
  end

  # instructions
  def welcome_message # rubocop:disable Metrics/MethodLength
    puts '=============================='
    puts '   Welcome to Tic Tac Toe! '
    puts '=============================='
    puts
    puts 'Player 1: X'
    puts 'Player 2: O'
    puts
    puts 'How to play:'
    puts '- The board is a 3x3 grid.'
    puts '- Enter your move as: row column'
    puts "  Example: '1 2' means row 1, column 2."
    puts '
             0   1   2
          0    |   |
            ---+---+---
          1    |   | X
            ---+---+---
          2    |   |    '
    puts '- First player to get 3 in a row wins!'
    puts
    puts 'Let’s begin!'
    puts
  end

  def create_board
    Array.new(3) { Array.new(3, ' ') }
  end

  def print_board
    puts '  0   1   2'
    sep = ' ---+---+---'
    @board.each_with_index do |row, r|
      print r
      puts " #{row[0]} | #{row[1]} | #{row[2]} "
      puts sep unless r == 2
    end
    puts
  end

  def current_player
    [@player1, @player2][@current_player_index]
  end

  def switch_turn
    @current_player_index = (@current_player_index + 1) % [@player1, @player2].size
  end

  def valid_move?(row, col)
    (0..2).include?(row) && (0..2).include?(col) && @board[row][col] == ' '
  end

  def player_turn # rubocop:disable Metrics/MethodLength
    loop do
      puts "Player #{current_player.number} (#{current_player.symbol}) enter your move (row col):"
      input = gets.chomp
      row, col = input.split.map(&:to_i)

      if valid_move?(row, col)
        @board[row][col] = current_player.symbol
        print_board
        switch_turn
        break # exit loop after successful move
      else
        puts 'Invalid move, try again.'
      end
    end
  end

  def winner?
    # Rows
    @board.each do |row|
      first = row.first
      return first if row.uniq.size == 1 && first != ' '
    end

    # Columns
    (0..2).each do |col|
      column = [@board[0][col], @board[1][col], @board[2][col]]
      first = column.first
      return first if column.uniq.size == 1 && first != ' '
    end

    # Diagonals
    diagonal1 = [@board[0][0], @board[1][1], @board[2][2]]
    return diagonal1.first if diagonal1.uniq.size == 1 && diagonal1.first != ' '

    diagonal2 = [@board[0][2], @board[1][1], @board[2][0]]
    return diagonal2.first if diagonal2.uniq.size == 1 && diagonal2.first != ' '

    nil
  end

  def draw?
    @board.flatten.none? { |cell| cell == ' ' } && winner?.nil?
  end

  def play
    loop do
      print_board
      player_turn
      if winner = winner?
        puts "Player #{winner} wins!"
        break
      elsif draw?
        puts "It's a draw!"
        break
      end
    end
    puts 'Game over!'
  end
end

Game.new.play if __FILE__ == $PROGRAM_NAME
