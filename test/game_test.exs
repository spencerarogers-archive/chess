defmodule GameTest do
  use ExUnit.Case
  doctest Chess

  setup do
    {:ok, game: %Chess.Game{}}
  end

  test "a valid move", context do
    game = context[:game]

    piece  = Chess.Board.piece_at(game.board, {1, 2})
    {:ok, game2} = Chess.Game.move(game, {1, 2}, {1, 3})

    assert(Chess.Board.piece_at(game2.board, {1, 3}) == piece)
    assert(Chess.Board.piece_at(game2.board, {1, 2}) == nil)
  end

  test "an invalid move", context do
    game = context[:game]

    piece  = Chess.Board.piece_at(game.board, {1, 2})
    {:invalid, game2} = Chess.Game.move(game, {1, 2}, {2, 3})

    assert(Chess.Board.piece_at(game2.board, {2, 3}) == nil)
    assert(Chess.Board.piece_at(game2.board, {1, 2}) == piece)
  end
end
