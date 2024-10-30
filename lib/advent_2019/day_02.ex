defmodule Advent2019.Day02 do
  @moduledoc """
  --- Day 2: 1202 Program Alarm ---

  https://adventofcode.com/2019/day/2
  """

  @doc """
  Before running the program, replace position `1` with the value `12` and
  replace position `2` with the value `2`.

  What value is left at position 0 after the program halts?
  """
  def part_1(program, noun \\ 12, verb \\ 2) do
    program
    |> List.replace_at(1, noun)
    |> List.replace_at(2, verb)
    |> run_program()
    |> List.first()
  end

  @doc """
  Find the input `noun` and `verb` that cause the program to produce the given
  output. What is `100 * noun + verb`?

  (For example, if `noun=12` and `verb=2`, the answer would be `1202`.)
  """
  def part_2(program, output) do
    for noun <- 0..99, verb <- 0..99, part_1(program, noun, verb) == output do
      throw(100 * noun + verb)
    end
  catch
    result -> result
  end

  @doc """
  Runs the program.

  ## Examples

    iex> Day02.run_program([1, 9, 10, 3, 2, 3, 11, 0, 99, 30, 40, 50], 0)
    [3500, 9, 10, 70, 2, 3, 11, 0, 99, 30, 40, 50]

    iex> Day02.run_program([1, 0, 0, 0, 99], 0)
    [2, 0, 0, 0, 99]

    iex> Day02.run_program([2, 3, 0, 3, 99], 0)
    [2, 3, 0, 6, 99]

    iex> Day02.run_program([2, 4, 4, 5, 99, 0], 0)
    [2, 4, 4, 5, 99, 9801]

    iex> Day02.run_program([1, 1, 1, 4, 99, 5, 6, 0, 99], 0)
    [30, 1, 1, 4, 2, 5, 6, 0, 99]

  """
  def run_program(program, pos \\ 0) do
    case Enum.slice(program, pos, 4) do
      [1, a, b, c] ->
        result = Enum.at(program, a) + Enum.at(program, b)

        program
        |> List.replace_at(c, result)
        |> run_program(pos + 4)

      [2, a, b, c] ->
        result = Enum.at(program, a) * Enum.at(program, b)

        program
        |> List.replace_at(c, result)
        |> run_program(pos + 4)

      [99 | _] ->
        program
    end
  end
end
