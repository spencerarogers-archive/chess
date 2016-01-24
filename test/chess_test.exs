defmodule ChessTest do
  use ExUnit.Case
  doctest Chess

  test "making a valid move" do
    board = Chess.new_board
    piece = Chess.piece_at(board, {:a, 2})
    Chess.move(board, {:a, 2}, {:a, 3})
    assert(Chess.piece_at(board, {:a, 2}) == piece)
  end
end
