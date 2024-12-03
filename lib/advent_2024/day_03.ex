defmodule Advent2024.Day03 do
  @moduledoc """
  --- Day 3: Mull It Over ---

  https://adventofcode.com/2024/day/3
  """

  @doc """
  Scan the corrupted memory for uncorrupted mul instructions.
  What do you get if you add up all of the results of the multiplications?

  ## Example

      iex> memory = "xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))"
      iex> Day03.part_1(memory)
      161

  """
  def part_1(instructions) do
    ~r/mul\(([\d]{1,3}),([\d]{1,3})\)/
    |> Regex.scan(instructions)
    |> Enum.reduce(0, fn [_, a, b], total ->
      total + String.to_integer(a) * String.to_integer(b)
    end)
  end

  @doc """
  Only the most recent `do()` or `don't()` instruction applies. At the beginning
  of the program, mul instructions are enabled.

  What do you get if you add up all of the results of just the enabled
  multiplications?

  ## Example

      iex> memory = "xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))"
      iex> Day03.part_2(memory)
      48

  """
  def part_2(instructions) do
    instructions
    |> String.split("do()")
    |> Enum.reduce(0, fn part, total ->
      [enabled | _] = String.split(part, "don't()")
      total + part_1(enabled)
    end)
  end
end
