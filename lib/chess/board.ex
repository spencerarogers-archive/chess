defmodule Chess.Board do
  import Chess.Piece

  @new_board_path "lib/chess/boards/new.txt"

  @x_axis [:a, :b, :c, :d, :e, :f, :g, :h]
  @y_axis [8, 7, 6, 5, 4, 3, 2, 1]

  def new do
    @new_board_path
    |> File.read!
    |> deserialize
  end

  def empty_board do
    @y_axis |> Enum.reduce %{}, fn y, a1 ->
      row = @x_axis |> Enum.reduce %{}, fn(x, a2) ->
                         a2 |> Map.put({x,y}, nil)
                       end

      Map.merge(a1, row)
    end
  end

  def piece_at(board, {x, y}) do
    board[{x,y}]
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

    StringIO.contents(pid)
    |> Tuple.to_list
    |> Enum.each fn row ->
      IO.write(row)
    end
  end

  def deserialize(str) do
    empty_board
    |> deserialize(@x_axis, @y_axis, String.next_codepoint(str))
  end
  def deserialize(board, [x | x_axis], y_axis, {codepoint, str}) do
    y = y_axis |> List.first

    board
    |> Map.put({x,y}, utf8_to_piece(codepoint))
    |> deserialize(x_axis, y_axis, String.next_codepoint(str))
  end
  def deserialize(board, x_axis, [y | y_axis], {"\n", str}) do
    board
    |> deserialize(@x_axis, y_axis, String.next_codepoint(str))
  end
  def deserialize(board, x_axis, y_axis, nil) do
    board
  end
end
