defmodule GameTest do
  use ExUnit.Case
  doctest Chess

  setup do
    {:ok, game: Chess.Game.new}
  end

  test "a valid move", context do
    game = context[:game]

    piece  = Chess.Board.piece_at(game.board, {:a, 2})
    {:ok, game2} = Chess.Game.move(game, {:a, 2}, {:a, 3})

    assert(Chess.Board.piece_at(game2.board, {:a, 3}) == piece)
    assert(Chess.Board.piece_at(game2.board, {:a, 2}) == nil)
  end

  test "an invalid move", context do
    game = context[:game]

    piece  = Chess.Board.piece_at(game.board, {:a, 2})
    {:invalid_move, game2} = Chess.Game.move(game, {:a, 2}, {:b, 3})

    assert(Chess.Board.piece_at(game2.board, {:b, 3}) == nil)
    assert(Chess.Board.piece_at(game2.board, {:a, 2}) == piece)
  end
end
