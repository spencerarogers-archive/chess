defmodule Chess.Piece do
  defstruct name: nil, color: nil

  @pieces [:k, :q, :r, :b, :n, :p]
  @pieces_to_utf8 %{
    :k => %{ :w => '♔', :b => '♚' },
    :q => %{ :w => '♕', :b => '♛' },
    :r => %{ :w => '♖', :b => '♜' },
    :b => %{ :w => '♗', :b => '♝' },
    :n => %{ :w => '♘', :b => '♞' },
    :p => %{ :w => '♙', :b => '♟' }
  }

  @utf8_to_pieces %{
    '♔' => {:k, :w},
    '♕' => {:q, :w},
    '♖' => {:r, :w},
    '♗' => {:b, :w},
    '♘' => {:n, :w},
    '♙' => {:p, :w},
    '♚' => {:k, :b},
    '♛' => {:q, :b},
    '♜' => {:r, :b},
    '♝' => {:b, :b},
    '♞' => {:n, :b},
    '♟' => {:p, :b}
  }

  def valid_movements(board, {x1,y1}) do
    [{:c, 1}]
  end

  @pieces |> Enum.each fn name ->
    def unquote(name)(color) do
      %Chess.Piece{ name: unquote(name), color: color }
    end
  end
end
