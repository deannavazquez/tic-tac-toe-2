require 'minitest/autorun'
require_relative '../lib/player'

class TestBoard < Minitest::Test
  def test_print_symbol
    player = Player.new(1, 'X')
    assert_equal 'Player 1 is X', player.print_symbol
  end

  def test_player
    player = Player.new(2, 'O')
    assert_equal 2, player.number
    assert_equal 'O', player.symbol
  end
end
