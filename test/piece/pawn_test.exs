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

  test "moves from home row", context do
    context[:board]
    |> Chess.Board.valid_movements({1,2})
    |> assert_moves_equal([{1,3}, {1,4}])
  end

  test "moves from non-home row", context do
    context[:board]
    |> Chess.Board.valid_movements({5,3})
    |> assert_moves_equal([{4,4},{5,4},{6,4}])
  end

  test "moves from close obstructed home row", context do
    context[:board]
    |> Chess.Board.valid_movements({3,2})
    |> assert_moves_equal([])
  end

  test "moves from far obstructed home row", context do
    context[:board]
    |> Chess.Board.valid_movements({4,2})
    |> assert_moves_equal([{3,3},{4,3}])
  end

  test "moves from fully obstructed home row", context do
    context[:board]
    |> Chess.Board.valid_movements({6,2})
    |> assert_moves_equal([])
  end
end
