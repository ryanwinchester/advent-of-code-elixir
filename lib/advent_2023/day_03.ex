defmodule Advent2023.Day03 do
  @moduledoc """
  --- Day 3: Gear Ratios ---

  https://adventofcode.com/2023/day/3

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @doc """
  What is the sum of all of the valid part numbers in the engine schematic?

  ## Examples

      iex> input = %{
      ...>   parts: %{
      ...>     {0, 0..2} => 467,
      ...>     {0, 5..7} => 114,
      ...>     {2, 2..3} => 35,
      ...>     {2, 6..8} => 633,
      ...>     {4, 0..2} => 617,
      ...>     {5, 7..8} => 58,
      ...>     {6, 2..4} => 592,
      ...>     {7, 6..8} => 755,
      ...>     {9, 1..3} => 664,
      ...>     {9, 5..7} => 598
      ...>   },
      ...>   symbols: %{
      ...>     {1, 3} => "*",
      ...>     {3, 6} => "#",
      ...>     {4, 3} => "*",
      ...>     {5, 5} => "+",
      ...>     {8, 3} => "$",
      ...>     {8, 5} => "*"
      ...>   }
      ...> }
      iex> part_1(input)
      4361

      iex> input = %{
      ...>   parts: %{
      ...>     {0, 0..1} => 12,
      ...>     {1, 10..11} => 34,
      ...>     {2, 8..9} => 12,
      ...>     {3, 2..3} => 78,
      ...>     {4, 7..8} => 60,
      ...>     {5, 0..1} => 78,
      ...>     {6, 7..8} => 23,
      ...>     {7, 4..5} => 90,
      ...>     {7, 7..8} => 12,
      ...>     {9, 0..0} => 2,
      ...>     {9, 2..2} => 2,
      ...>     {9, 9..10} => 12,
      ...>     {11, 0..0} => 1,
      ...>     {11, 2..2} => 1,
      ...>     {11, 10..11} => 56
      ...>   },
      ...>   symbols: %{
      ...>     {0, 9} => "*",
      ...>     {1, 0} => "+",
      ...>     {2, 7} => "-",
      ...>     {4, 2} => "*",
      ...>     {7, 6} => "*",
      ...>     {10, 1} => "*",
      ...>     {10, 11} => "*"
      ...>   }
      ...> }
      iex> part_1(input)
      413

  """
  def part_1(%{parts: parts, symbols: symbols}) do
    parts
    |> Enum.filter(&valid_part?(&1, Map.keys(symbols)))
    |> Enum.reduce(0, fn {_, part}, total -> part + total end)
  end

  defp valid_part?({{x0, y_range}, _part}, symbols) do
    for y0 <- y_range,
        x <- (x0 - 1)..(x0 + 1),
        y <- (y0 - 1)..(y0 + 1),
        reduce: false do
      false -> {x, y} in symbols
      true -> throw(:break)
    end
  catch
    :break -> true
  end

  @doc """
  What is the sum of all of the gear ratios in your engine schematic?

  ## Examples

      iex> input = %{
      ...>   parts: %{
      ...>     {0, 0..2} => 467,
      ...>     {0, 5..7} => 114,
      ...>     {2, 2..3} => 35,
      ...>     {2, 6..8} => 633,
      ...>     {4, 0..2} => 617,
      ...>     {5, 7..8} => 58,
      ...>     {6, 2..4} => 592,
      ...>     {7, 6..8} => 755,
      ...>     {9, 1..3} => 664,
      ...>     {9, 5..7} => 598
      ...>   },
      ...>   symbols: %{
      ...>     {1, 3} => "*",
      ...>     {3, 6} => "#",
      ...>     {4, 3} => "*",
      ...>     {5, 5} => "+",
      ...>     {8, 3} => "$",
      ...>     {8, 5} => "*"
      ...>   }
      ...> }
      iex> part_2(input)
      467835

  """
  def part_2(%{parts: parts, symbols: symbols}) do
    Enum.reduce(symbols, 0, fn
      {{x0, y0}, "*"}, total -> gear_ratio({x0, y0}, parts) + total
      _symbol, total -> total
    end)
  end

  defp gear_ratio({x0, y0}, parts) do
    case adjacent_parts({x0, y0}, parts) do
      [a, b] -> a * b
      _not_pair -> 0
    end
  end

  defp adjacent_parts({x0, y0}, parts) do
    for x <- (x0 - 1)..(x0 + 1),
        y <- (y0 - 1)..(y0 + 1),
        {{x0p, y_range}, part} <- parts,
        x == x0p and y in y_range,
        uniq: true do
      part
    end
  end
end
