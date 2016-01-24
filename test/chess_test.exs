defmodule ChessTest do
  use ExUnit.Case
  doctest Chess

  test "making a valid move" do
    board = Chess.Board.new
    piece = Chess.Game.piece_at(board, {:b, 1})

    assert(Chess.Game.piece_at(board, {:c, 1}) == nil)
    assert(Chess.Game.piece_at(board, {:b, 1}) == piece)

    new_board = Chess.Game.move(board, {:b, 1}, {:c, 1})

    assert(Chess.Game.piece_at(new_board, {:c, 1}) == piece)
    assert(Chess.Game.piece_at(new_board, {:b, 1}) == nil)
  end
end
