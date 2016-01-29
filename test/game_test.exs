defmodule GameTest do
  use ExUnit.Case
  doctest Chess

  setup do
    {:ok, board: Chess.Board.new}
  end

  test "a valid move", context do
    board = context[:board]

    piece  = Chess.Board.piece_at(board, {:b, 1})
    board2 = Chess.Game.move(board, {:b, 1}, {:c, 1})

    assert(Chess.Board.piece_at(board2, {:c, 1}) == piece)
    assert(Chess.Board.piece_at(board2, {:b, 1}) == nil)
  end

  test "an invalid move", context do
    board = context[:board]

    piece  = Chess.Board.piece_at(board, {:b, 1})
    board2 = Chess.Game.move(board, {:b, 1}, {:c, 2})

    assert(Chess.Board.piece_at(board2, {:c, 1}) == nil)
    assert(Chess.Board.piece_at(board2, {:b, 1}) == piece)
  end
end
