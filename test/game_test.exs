defmodule GameTest do
  use ExUnit.Case
  doctest Chess

  setup do
    {:ok, game: %Chess.Game{}}
  end

  test "a valid move", context do
    game = context[:game]

    piece = Chess.Board.piece_at(game.board, {1, 2})
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

  test "a capture" do
    game = %Chess.Game{board: Chess.Board.load('test/fixtures/pawn.txt')}

    piece = Chess.Board.piece_at(game.board, {7, 3})
    captured = Chess.Board.piece_at(game.board, {6, 4})

    {:ok, game} = Chess.Game.move(game, {7, 3}, {6, 4})

    assert(Enum.member?(game.white_captures, captured))
    assert(Chess.Board.piece_at(game.board, {6, 4}) == piece)
    assert(Chess.Board.piece_at(game.board, {7, 3}) == nil)
  end
end
