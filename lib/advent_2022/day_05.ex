defmodule Advent2022.Day05 do
  @moduledoc """
  --- Day 5: Supply Stacks ---

  https://adventofcode.com/2022/day/5
  """

  @doc """
  After the rearrangement procedure completes, what crate ends up on top of
  each stack?

  ## Example

      iex> rows = [[" ", "D", " "], ["N", "C", " "], ["Z", "M", "P"]]
      iex> moves = [{1, 2, 1}, {3, 1, 3}, {2, 2, 1}, {1, 1, 2}]
      iex> part_1(rows, moves)
      "CMZ"

  """
  def part_1(rows, moves), do: rearrange(rows, moves, 9000)

  @doc """
  After the rearrangement procedure completes, what crate ends up on top of
  each stack?

  ## Example

      iex> rows = [[" ", "D", " "], ["N", "C", " "], ["Z", "M", "P"]]
      iex> moves = [{1, 2, 1}, {3, 1, 3}, {2, 2, 1}, {1, 1, 2}]
      iex> part_2(rows, moves)
      "MCD"

  """
  def part_2(rows, moves), do: rearrange(rows, moves, 9001)

  defp rearrange(rows, moves, crane_model) do
    Enum.reduce(moves, rows_to_stacks(rows), fn {qty, from, to}, stacks ->
      {crates, from_stack} = Enum.split(stacks[from], qty)

      stacks
      |> Map.put(from, from_stack)
      |> Map.update!(to, &move_crates(crane_model, crates, &1))
    end)
    |> Map.values()
    |> Enum.map(&hd/1)
    |> IO.iodata_to_binary()
  end

  defp rows_to_stacks(rows) do
    rows
    |> transpose()
    |> Enum.with_index()
    |> Enum.into(%{}, fn {stack, i} ->
      {i + 1, Enum.reject(stack, &(&1 == " "))}
    end)
  end

  defp transpose(rows) do
    rows
    |> List.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  defp move_crates(9000, crates, stack), do: Enum.reverse(crates) ++ stack
  defp move_crates(9001, crates, stack), do: crates ++ stack
end
