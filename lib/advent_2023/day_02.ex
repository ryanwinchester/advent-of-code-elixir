defmodule Advent2023.Day02 do
  @moduledoc """
  --- Day 2: Cube Conundrum ---

  https://adventofcode.com/2023/day/2

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @doc """
  Determine which games would have been possible if the bag had been loaded
  with only 12 red cubes, 13 green cubes, and 14 blue cubes.

  What is the sum of the IDs of those games?

  ## Examples

      iex> input = %{
      ...>   1 => [
      ...>     %{
      ...>       "blue" => 3,
      ...>       "red" => 4
      ...>     },
      ...>     %{
      ...>       "red" => 1,
      ...>       "green" => 2,
      ...>       "blue" => 6
      ...>     },
      ...>     %{
      ...>         "green" => 2
      ...>     }
      ...>   ],
      ...>   2 => [
      ...>     %{
      ...>       "blue" => 1,
      ...>       "green" => 2
      ...>     },
      ...>     %{
      ...>       "green" => 3,
      ...>       "blue" => 4,
      ...>       "red" => 1
      ...>     },
      ...>     %{
      ...>       "green" => 1,
      ...>       "blue" => 1
      ...>     }
      ...>   ],
      ...>   3 => [
      ...>     %{
      ...>       "green" => 8,
      ...>       "blue" => 6,
      ...>       "red" => 20
      ...>     },
      ...>     %{
      ...>       "blue" => 5,
      ...>       "red" => 4,
      ...>       "green" => 13
      ...>     },
      ...>     %{
      ...>       "green" => 5,
      ...>       "red" => 1
      ...>     }
      ...>   ],
      ...>   4 => [
      ...>     %{
      ...>       "green" => 1,
      ...>       "red" => 3,
      ...>       "blue" => 6
      ...>     },
      ...>     %{
      ...>       "green" => 3,
      ...>       "red" => 6
      ...>     },
      ...>     %{
      ...>       "green" => 3,
      ...>       "blue" => 15,
      ...>       "red" => 14
      ...>     }
      ...>   ],
      ...>   5 => [
      ...>     %{
      ...>       "red" => 6,
      ...>       "blue" => 1,
      ...>       "green" => 3
      ...>     },
      ...>     %{
      ...>       "blue" => 2,
      ...>       "red" => 1,
      ...>       "green" => 2
      ...>     }
      ...>   ]
      ...> }
      iex> part_1(input)
      8

  """
  def part_1(input) do
    input
    |> Enum.filter(fn {_, handfuls} ->
      Enum.all?(handfuls, fn h ->
        (is_nil(h["red"]) or h["red"] <= 12) and (is_nil(h["green"]) or h["green"] <= 13) and
          (is_nil(h["blue"]) or h["blue"] <= 14)
      end)
    end)
    |> Enum.reduce(0, fn {id, _}, total -> id + total end)
  end

  @doc """
  Determine which games would have been possible if the bag had been loaded
  with only 12 red cubes, 13 green cubes, and 14 blue cubes.

  What is the sum of the IDs of those games?

  ## Examples

      iex> input = %{
      ...>   1 => [
      ...>     %{
      ...>       "blue" => 3,
      ...>       "red" => 4
      ...>     },
      ...>     %{
      ...>       "red" => 1,
      ...>       "green" => 2,
      ...>       "blue" => 6
      ...>     },
      ...>     %{
      ...>         "green" => 2
      ...>     }
      ...>   ],
      ...>   2 => [
      ...>     %{
      ...>       "blue" => 1,
      ...>       "green" => 2
      ...>     },
      ...>     %{
      ...>       "green" => 3,
      ...>       "blue" => 4,
      ...>       "red" => 1
      ...>     },
      ...>     %{
      ...>       "green" => 1,
      ...>       "blue" => 1
      ...>     }
      ...>   ],
      ...>   3 => [
      ...>     %{
      ...>       "green" => 8,
      ...>       "blue" => 6,
      ...>       "red" => 20
      ...>     },
      ...>     %{
      ...>       "blue" => 5,
      ...>       "red" => 4,
      ...>       "green" => 13
      ...>     },
      ...>     %{
      ...>       "green" => 5,
      ...>       "red" => 1
      ...>     }
      ...>   ],
      ...>   4 => [
      ...>     %{
      ...>       "green" => 1,
      ...>       "red" => 3,
      ...>       "blue" => 6
      ...>     },
      ...>     %{
      ...>       "green" => 3,
      ...>       "red" => 6
      ...>     },
      ...>     %{
      ...>       "green" => 3,
      ...>       "blue" => 15,
      ...>       "red" => 14
      ...>     }
      ...>   ],
      ...>   5 => [
      ...>     %{
      ...>       "red" => 6,
      ...>       "blue" => 1,
      ...>       "green" => 3
      ...>     },
      ...>     %{
      ...>       "blue" => 2,
      ...>       "red" => 1,
      ...>       "green" => 2
      ...>     }
      ...>   ]
      ...> }
      iex> part_2(input)
      2286

  """
  def part_2(input) do
    input
    |> Enum.map(fn {_game_id, handfuls} -> cube_powers(handfuls) end)
    |> Enum.reduce(0, fn {r, g, b}, total -> r * g * b + total end)
  end

  defp cube_powers(handfuls) do
    Enum.reduce(handfuls, {0, 0, 0}, fn handful, {r, g, b} ->
      {max(handful["red"] || 0, r), max(handful["green"] || 0, g), max(handful["blue"] || 0, b)}
    end)
  end
end
