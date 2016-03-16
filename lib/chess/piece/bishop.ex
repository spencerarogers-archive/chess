defmodule Chess.Piece.Bishop do
  defstruct type: :bishop, color: nil
end

defimpl Chess.Piece, for: Chess.Piece.Bishop do
  def serialize(piece) do
    case piece.color do
      :white -> "♗"
      :black -> "♝"
    end
  end
end
