defmodule LevelMap do
  @room_size 2

  def gen(size \\ @room_size) do
    gencol size
  end

  defp floor_cell(x, y), do: %Cell{ type: "FLOOR", x: x, y: y }

  defp genrow(list, x, y, size) when x > size do
    list |> Enum.reverse
  end

  defp genrow(list, x, y, size) do
    [floor_cell(x, y) | list]
    |> genrow(x + 1, y, size)
  end

  defp gencol(col) do
    0..col
    |> Enum.map(fn(x) -> genrow([], 0, x, col) end)
    |> List.flatten
  end
end
