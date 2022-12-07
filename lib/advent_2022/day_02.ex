defmodule Advent2022.Day02 do
  @moduledoc """
  --- Day 2: Rock Paper Scissors ---

  https://adventofcode.com/2022/day/2

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @scores %{ROCK: 1, PAPER: 2, SCISSORS: 3, LOSE: 0, DRAW: 3, WIN: 6}

  @doc """
  What would your total score be if everything goes exactly according to
  your strategy guide?

  ## Example

      iex> rounds = [["A", "Y"], ["B", "X"], ["C", "Z"]]
      iex> part_1(rounds)
      15

  """
  def part_1(rounds) do
    Enum.reduce(rounds, 0, &play_1/2)
  end

  defp play_1(["A", "X"], score), do: score + @scores[:ROCK] + @scores[:DRAW]
  defp play_1(["A", "Y"], score), do: score + @scores[:PAPER] + @scores[:WIN]
  defp play_1(["A", "Z"], score), do: score + @scores[:SCISSORS] + @scores[:LOSE]

  defp play_1(["B", "X"], score), do: score + @scores[:ROCK] + @scores[:LOSE]
  defp play_1(["B", "Y"], score), do: score + @scores[:PAPER] + @scores[:DRAW]
  defp play_1(["B", "Z"], score), do: score + @scores[:SCISSORS] + @scores[:WIN]

  defp play_1(["C", "X"], score), do: score + @scores[:ROCK] + @scores[:WIN]
  defp play_1(["C", "Y"], score), do: score + @scores[:PAPER] + @scores[:LOSE]
  defp play_1(["C", "Z"], score), do: score + @scores[:SCISSORS] + @scores[:DRAW]

  @doc """
  Following the Elf's instructions for the second column, what would your total
  score be if everything goes exactly according to your strategy guide?

  ## Example

      iex> rounds = [["A", "Y"], ["B", "X"], ["C", "Z"]]
      iex> part_2(rounds)
      12

  """
  def part_2(rounds) do
    Enum.reduce(rounds, 0, &play_2/2)
  end

  defp play_2(["A", "X"], score), do: score + @scores[:SCISSORS] + @scores[:LOSE]
  defp play_2(["A", "Y"], score), do: score + @scores[:ROCK] + @scores[:DRAW]
  defp play_2(["A", "Z"], score), do: score + @scores[:PAPER] + @scores[:WIN]

  defp play_2(["B", "X"], score), do: score + @scores[:ROCK] + @scores[:LOSE]
  defp play_2(["B", "Y"], score), do: score + @scores[:PAPER] + @scores[:DRAW]
  defp play_2(["B", "Z"], score), do: score + @scores[:SCISSORS] + @scores[:WIN]

  defp play_2(["C", "X"], score), do: score + @scores[:PAPER] + @scores[:LOSE]
  defp play_2(["C", "Y"], score), do: score + @scores[:SCISSORS] + @scores[:DRAW]
  defp play_2(["C", "Z"], score), do: score + @scores[:ROCK] + @scores[:WIN]
end
