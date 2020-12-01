defmodule Advent.Day1 do

  @doc """
  Take the list of expense entries to find the solution.

  Accepts a filename of items or the list.
  """
  def part_1(filename) when is_binary(filename) do
    filename
    |> File.read!()
    |> String.split("\n", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> part_1()
  end

  def part_1(entries) when is_list(entries) do
    entries
    |> Enum.with_index()
    |> get_results()
    |> List.first()
  end

  # Brute force method, don't judge me.
  defp get_results(items) do
    for {x, i} <- items, {y, j} <- items, i != j and x + y == 2020 do
      x * y
    end
  end
end
