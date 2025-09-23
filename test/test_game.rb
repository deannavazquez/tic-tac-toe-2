require 'minitest/autorun'
require_relative '../lib/game'

class TestGame < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_create_board_starts_empty
    board = @game.create_board
    assert_equal 3, board.size
    assert(board.all? { |row| row.all? { |cell| cell == ' ' } })
  end

  def test_valid_move_on_empty_square
    assert @game.valid_move?(0, 0)
  end

  def test_invalid_move_out_of_bounds
    refute @game.valid_move?(3, 3) # outside 0–2
  end

  def test_invalid_move_on_taken_square
    @game.board[0][0] = 'X'
    refute @game.valid_move?(0, 0)
  end
end
