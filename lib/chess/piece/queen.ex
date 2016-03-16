defmodule Chess.Piece.Queen do
  defstruct type: :queen, color: nil
end

defimpl Chess.Piece, for: Chess.Piece.Queen do
  def serialize(piece) do
    case piece.color do
      :white -> "♕"
      :black -> "♛"
    end
  end
end
