defmodule LevelMap do
  @room_size 2

  def gen(size \\ @room_size) do
    gencol size
  end

  defp floor_cell(x, y), do: %Cell{ type: "FLOOR", x: x, y: y }

  defp genrow(list, %{x: x, y: y, max: max}) when x > max do
    list |> Enum.reverse
  end

  defp genrow(list, %{x: x, y: y, max: max}) do
    [floor_cell(x, y) | list] |> genrow(%{x: x + 1, y: y, max: max})
  end

  defp gencol(max) do
    0..max
    |> Enum.map(fn(y) -> genrow([], %{y: y, x: 0, max: max}) end)
    |> List.flatten
  end
end
