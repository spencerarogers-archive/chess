defmodule Chess.Piece do
  defstruct name: nil, color: nil

  @piece_modules %{
    :k => Chess.Piece.King,
    :q => Chess.Piece.Queen,
    :r => Chess.Piece.Rook,
    :b => Chess.Piece.Bishop,
    :n => Chess.Piece.Knight,
    :p => Chess.Piece.Pawn
  }

  def valid_movements(board, {x1,y1}) do
    %Chess.Piece{name: piece_type, color: color} = board |> Chess.Board.piece_at({x1,y1})
    piece_module = Map.get(@piece_modules, piece_type)

    piece_module.move_definitions(board, color)
    |> Enum.reduce(MapSet.new, fn (move_func, set) ->
      move_func.({x1,y1})
      |> case do
        [head | tail] ->
          [head | tail]
          |> Enum.reduce(set, &(MapSet.put(&2,&1)))
        {x2,y2} ->
          MapSet.put(set, {x2,y2})
        [] ->
          set
        nil ->
          set
      end
    end)
  end
end
