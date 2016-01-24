defmodule ChessTest do
  use ExUnit.Case
  doctest Chess

  test "making a valid move" do
    board = Chess.new_board
    piece = Chess.piece_at(board, :a2)
    Chess.move(board, :a2, :a3)
    assert(Chess.piece_at(board, :a2) == piece)
  end
end
