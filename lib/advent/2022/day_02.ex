defmodule Advent2022.Day02 do
  @moduledoc """
  --- Day 2: Rock Paper Scissors ---

  https://adventofcode.com/2022/day/2

  A: Rock B: Paper C: Scissors
  """

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

  @scores %{"R" => 1, "P" => 2, "S" => 3, lose: 0, draw: 3, win: 6}

  defp play_1(["A", "X"], score), do: score + @scores["R"] + @scores[:draw]
  defp play_1(["A", "Y"], score), do: score + @scores["P"] + @scores[:win]
  defp play_1(["A", "Z"], score), do: score + @scores["S"] + @scores[:lose]

  defp play_1(["B", "X"], score), do: score + @scores["R"] + @scores[:lose]
  defp play_1(["B", "Y"], score), do: score + @scores["P"] + @scores[:draw]
  defp play_1(["B", "Z"], score), do: score + @scores["S"] + @scores[:win]

  defp play_1(["C", "X"], score), do: score + @scores["R"] + @scores[:win]
  defp play_1(["C", "Y"], score), do: score + @scores["P"] + @scores[:lose]
  defp play_1(["C", "Z"], score), do: score + @scores["S"] + @scores[:draw]

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

  defp play_2(["A", "X"], score), do: score + @scores["S"] + @scores[:lose]
  defp play_2(["A", "Y"], score), do: score + @scores["R"] + @scores[:draw]
  defp play_2(["A", "Z"], score), do: score + @scores["P"] + @scores[:win]

  defp play_2(["B", "X"], score), do: score + @scores["R"] + @scores[:lose]
  defp play_2(["B", "Y"], score), do: score + @scores["P"] + @scores[:draw]
  defp play_2(["B", "Z"], score), do: score + @scores["S"] + @scores[:win]

  defp play_2(["C", "X"], score), do: score + @scores["P"] + @scores[:lose]
  defp play_2(["C", "Y"], score), do: score + @scores["S"] + @scores[:draw]
  defp play_2(["C", "Z"], score), do: score + @scores["R"] + @scores[:win]
end
