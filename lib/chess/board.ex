defmodule Chess.Board do
  import Chess.Piece

  @x_axis [ 1,  2,  3,  4,  5,  6,  7,  8]
  @y_axis [:h, :g, :f, :e, :d, :c, :b, :a]

  def new do
    %{
      h: %{1 => r(:b), 2 => k(:b), 3 => b(:b), 4 => q(:b), 5 => k(:b), 6 => b(:b), 7 => k(:b), 8 => r(:b)},
      g: %{1 => p(:b), 2 => p(:b), 3 => p(:b), 4 => p(:b), 5 => p(:b), 6 => p(:b), 7 => p(:b), 8 => p(:b)},
      f: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      e: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      d: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      c: %{1 => nil,   2 => nil,   3 => nil,   4 => nil,   5 => nil,   6 => nil,   7 => nil,   8 => nil  },
      b: %{1 => p(:w), 2 => p(:w), 3 => p(:w), 4 => p(:w), 5 => p(:w), 6 => p(:w), 7 => p(:w), 8 => p(:w)},
      a: %{1 => r(:w), 2 => k(:w), 3 => b(:w), 4 => q(:w), 5 => k(:w), 6 => b(:w), 7 => k(:w), 8 => r(:w)}
    }
  end

  def piece_at(board, {x, y}) do
    board[y][x]
  end

  def serialize(board) do
    {:ok, pid} = StringIO.open("")

    @y_axis |> Enum.each fn y ->
      @x_axis |> Enum.each fn x ->
        char = board
               |> piece_at({x,y})
               |> piece_to_utf8

        IO.write(pid, char)
      end
      IO.write(pid, "\n")
    end

    StringIO.contents(pid) |> Tuple.to_list |> Enum.each fn row ->
      IO.write(row)
    end
  end

  def deserialize do
    # TODO
  end
end
