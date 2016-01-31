defmodule GameTest do
  use ExUnit.Case
  doctest Chess

  setup do
    {:ok, board: Chess.Board.new}
  end

  test "a valid move", context do
    board = context[:board]

    piece  = Chess.Board.piece_at(board, {:a, 2})
    board2 = Chess.Game.move(board, {:a, 2}, {:a, 3})

    assert(Chess.Board.piece_at(board2, {:a, 3}) == piece)
    assert(Chess.Board.piece_at(board2, {:a, 2}) == nil)
  end

  test "an invalid move", context do
    board = context[:board]

    piece  = Chess.Board.piece_at(board, {:a, 2})
    board2 = Chess.Game.move(board, {:a, 2}, {:b, 3})

    assert(Chess.Board.piece_at(board2, {:b, 3}) == nil)
    assert(Chess.Board.piece_at(board2, {:a, 2}) == piece)
  end
end
