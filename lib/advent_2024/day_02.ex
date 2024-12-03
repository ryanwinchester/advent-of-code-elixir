defmodule Advent2024.Day02 do
  @moduledoc """
  --- Day 2: Red-Nosed Reports ---

  https://adventofcode.com/2024/day/2
  """

  @doc """
  What is the total distance between the lists?

  ## Example

      iex> reports = [
      ...>   [7, 6, 4, 2, 1],
      ...>   [1, 2, 7, 8, 9],
      ...>   [9, 7, 6, 2, 1],
      ...>   [1, 3, 2, 4, 5],
      ...>   [8, 6, 4, 4, 1],
      ...>   [1, 3, 6, 7, 9]
      ...> ]
      iex> Day02.part_1(reports)
      2

  """
  def part_1(reports) do
    reports
    |> Enum.map(&safe?(&1, nil))
    |> Enum.reduce(0, fn
      true, acc -> acc + 1
      false, acc -> acc
    end)
  end

  @doc """
  What is the total distance between the lists?

  ## Example

      iex> reports = [
      ...>   [7, 6, 4, 2, 1],
      ...>   [1, 2, 7, 8, 9],
      ...>   [9, 7, 6, 2, 1],
      ...>   [1, 3, 2, 4, 5],
      ...>   [8, 6, 4, 4, 1],
      ...>   [1, 3, 6, 7, 9]
      ...> ]
      iex> Day02.part_2(reports)
      4

  """
  def part_2(reports) do
    reports
    |> Enum.map(&safe?(&1, nil, 0))
    |> Enum.reduce(0, fn
      true, acc -> acc + 1
      false, acc -> acc
    end)
  end

  # In part 1, we only check if it's increasing or decreasing within the limit.
  defp safe?([a, b | rest], nil) when (a - b) in 1..3, do: safe?([b | rest], :inc)
  defp safe?([a, b | rest], nil) when (b - a) in 1..3, do: safe?([b | rest], :dec)
  defp safe?([a, b | rest], :inc) when (a - b) in 1..3, do: safe?([b | rest], :inc)
  defp safe?([a, b | rest], :dec) when (b - a) in 1..3, do: safe?([b | rest], :dec)
  defp safe?([_], _inc_dec), do: true
  defp safe?(_levels, _inc_dec), do: false

  # In part 2, we allow 1 unsafe level.
  defp safe?(_, _inc_dec, n) when n > 1, do: false
  defp safe?([_], _inc_dec, _n), do: true
  defp safe?([], _inc_dec, _n), do: true
  defp safe?([a, b | rest], nil, n) when (a - b) in 1..3, do: safe?([b | rest], :inc, n)
  defp safe?([a, b | rest], nil, n) when (b - a) in 1..3, do: safe?([b | rest], :dec, n)
  defp safe?([a, _b, c | rest], nil, n) when (c - a) in 1..3, do: safe?([c | rest], :dec, n + 1)
  defp safe?([_a, b, c | rest], nil, n) when (b - c) in 1..3, do: safe?([c | rest], :inc, n + 1)
  defp safe?([_a, b, c | rest], nil, n) when (c - b) in 1..3, do: safe?([c | rest], :dec, n + 1)
  defp safe?([a, b | rest], :inc, n) when (a - b) in 1..3, do: safe?([b | rest], :inc, n)
  defp safe?([a, b | rest], :dec, n) when (b - a) in 1..3, do: safe?([b | rest], :dec, n)
  defp safe?([a, _b | rest], inc_dec, n), do: safe?([a | rest], inc_dec, n + 1)
end
