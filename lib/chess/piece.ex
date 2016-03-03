defmodule Chess.Piece do
  defstruct name: nil, color: nil

  @pieces [:k, :q, :r, :b, :n, :p]
  @pieces_to_utf8 %{
    :k => %{ :w => "♔", :b => "♚" },
    :q => %{ :w => "♕", :b => "♛" },
    :r => %{ :w => "♖", :b => "♜" },
    :b => %{ :w => "♗", :b => "♝" },
    :n => %{ :w => "♘", :b => "♞" },
    :p => %{ :w => "♙", :b => "♟" }
  }

  @utf8_to_pieces %{
    "♔" => {:k, :w},
    "♕" => {:q, :w},
    "♖" => {:r, :w},
    "♗" => {:b, :w},
    "♘" => {:n, :w},
    "♙" => {:p, :w},
    "♚" => {:k, :b},
    "♛" => {:q, :b},
    "♜" => {:r, :b},
    "♝" => {:b, :b},
    "♞" => {:n, :b},
    "♟" => {:p, :b}
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

  def valid_movements(board, {x1,y1}) do
    %Chess.Piece{name: piece_type, color: color} = board |> Chess.Board.piece_at({x1,y1})

    case piece_type do
      :p ->
        board
        |> Chess.Piece.Pawn.moves(color)
        |> Enum.map(fn move -> move.({x1,y1}) end)
    end
  end
end
