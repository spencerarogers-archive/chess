defmodule ChessTest do
  use ExUnit.Case
  doctest Chess

  test "making a valid move" do
    board = Chess.Board.new
    piece = Chess.Game.piece_at(board, {:a, 2})
    Chess.Game.move(board, {:a, 2}, {:a, 3})
    assert(Chess.Game.piece_at(board, {:a, 2}) == piece)
  end
end
