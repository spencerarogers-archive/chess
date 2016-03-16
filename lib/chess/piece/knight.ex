defmodule Chess.Piece.Knight do
  defstruct type: :knight, color: nil
end

defimpl Chess.Piece, for: Chess.Piece.Knight do
  def serialize(piece) do
    case piece.color do
      :white -> "♘"
      :black -> "♞"
    end
  end
end
