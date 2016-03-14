defmodule Chess.Board do
  import Chess.Piece

  @new_board_path "lib/chess/board/new.txt"

  @x_axis [1, 2, 3, 4, 5, 6, 7, 8]
  @y_axis [8, 7, 6, 5, 4, 3, 2, 1]

  @min_x 1
  @min_y 1

  @max_x 8
  @max_y 8

  def min_x do
    @min_x
  end

  def min_y do
    @min_y
  end

  def max_x do
    @max_x
  end

  def max_y do
    @max_y
  end

  def new do
    load(@new_board_path)
  end

  def load(path) do
    path
    |> File.read!
    |> deserialize
  end

  def unoccupied?(board, space) do
    case Chess.Board.piece_at(board, space) do
      nil ->
        true
      _ ->
        false
    end
  end

  def empty_board do
    @y_axis |> Enum.reduce(%{}, fn y, a1 ->
      row = @x_axis |> Enum.reduce(%{}, fn(x, a2) ->
                         a2 |> Map.put({x,y}, nil)
                       end)

      Map.merge(a1, row)
    end)
  end

  def piece_at(board, {x,y}) do
    board[{x,y}]
  end

  def color_at(board, {x,y}) do
    piece = piece_at(board, {x,y})

    if piece do
      piece.color
    else
      nil
    end
  end

  def serialize(board) do
    {:ok, pid} = StringIO.open("")

    @y_axis |> Enum.each(fn y ->
      @x_axis |> Enum.each(fn x ->
        char = board
               |> piece_at({x,y})
               |> piece_to_utf8

        IO.write(pid, char)
      end)
      IO.write(pid, "\n")
    end)

    StringIO.contents(pid)
    |> Tuple.to_list
    |> Enum.join
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

  def deserialize(board, [], [y | y_axis], {_, str}) do
    board
    |> deserialize(@x_axis, y_axis, String.next_codepoint(str))
  end

  def deserialize(board, x_axis, [], _) do
    board
  end

  def x_to_int(x) do
    <<a>> = "a"
    <<x_int>> = x
    x_int - a + 1
  end
end
