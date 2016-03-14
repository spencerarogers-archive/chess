defmodule Chess.Piece.PawnTest do
  use ExUnit.Case
  doctest Chess

  def assert_moves_equal(actual, expected) do
    expected
    |> MapSet.new
    |> MapSet.equal?(actual)
    |> assert
  end

  setup do
    {:ok, [board: Chess.Board.load('test/fixtures/pawn.txt')]}
  end

  test "moving from home row", context do
    moves = context[:board]
    |> Chess.Piece.valid_movements({1,2})
    |> assert_moves_equal([{1,3}, {1,4}])
  end

  test "moving from non-home row", context do
    moves = context[:board]
    |> Chess.Piece.valid_movements({5,3})
    |> assert_moves_equal([{5,4}])
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
