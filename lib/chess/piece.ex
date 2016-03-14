defmodule Chess.Piece do
  defstruct name: nil, color: nil

  @pieces [:k, :q, :r, :b, :n, :p]
  @pieces_to_utf8 %{
    :k => %{ :white => "♔", :black => "♚" },
    :q => %{ :white => "♕", :black => "♛" },
    :r => %{ :white => "♖", :black => "♜" },
    :b => %{ :white => "♗", :black => "♝" },
    :n => %{ :white => "♘", :black => "♞" },
    :p => %{ :white => "♙", :black => "♟" }
  }

  @utf8_to_pieces %{
    "♔" => {:k, :white},
    "♕" => {:q, :white},
    "♖" => {:r, :white},
    "♗" => {:b, :white},
    "♘" => {:n, :white},
    "♙" => {:p, :white},
    "♚" => {:k, :black},
    "♛" => {:q, :black},
    "♜" => {:r, :black},
    "♝" => {:b, :black},
    "♞" => {:n, :black},
    "♟" => {:p, :black}
  }

  @piece_modules %{
    :k => Chess.Piece.King,
    :q => Chess.Piece.Queen,
    :r => Chess.Piece.Rook,
    :b => Chess.Piece.Bishop,
    :n => Chess.Piece.Knight,
    :p => Chess.Piece.Pawn
  }

  def piece_to_utf8(piece) do
    case piece do
      nil ->
        ' '
      _ ->
        @pieces_to_utf8[piece.name][piece.color]
    end
  end

  def utf8_to_piece(char) do
    case @utf8_to_pieces[char] do
      {name, color} ->
        %Chess.Piece{name: name, color: color}
      nil ->
        nil
    end
  end

  def home_row?(color, y) do
    case color do
      :white ->
        y == 2
      :black ->
        y == 7
    end
  end

  def relation(c1, c2) do
    if c1 && c2 do
      cond do
        c1 == c2 ->
          :friendly
        c1 != c2 ->
          :enemy
      end
    else
      nil
    end
  end

  def direction(color) do
    if(color == :white, do: 1, else: -1)
  end

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
