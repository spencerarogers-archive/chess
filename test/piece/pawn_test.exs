defmodule Chess.Piece.PawnTest do
  use ExUnit.Case
  doctest Chess

  setup do
    {:ok, [board: Chess.Board.load('test/fixtures/pawn.txt')]}
  end

  test "moving from home row", context do
    moves = context[:board]
    |> Chess.Piece.Pawn.moves({1,2})

    [{1,3}, {1,4}]
    |> MapSet.new
    |> MapSet.equal?(moves)
    |> assert
  end

  test "move forward 1 self-occupied space", context do
  end

  test "move forward 1 opponent-occupied space", context do
  end

  test "move forward 2 spaces from home row", context do
  end

  test "move forward 2 spaces from non-home row", context do
  end

  test "move forward 2 spaces from home row with obstruction", context do
  end
end
