defmodule Advent.Day08 do
  @moduledoc """
  --- Day 8: Handheld Halting ---
  https://adventofcode.com/2020/day/8
  """

  @doc """
  Return the value in the accumulator after the last successful instruction.

  ## Example

      iex> input = [
      ...>   "nop +0",
      ...>   "acc +1",
      ...>   "jmp +4",
      ...>   "acc +3",
      ...>   "jmp -3",
      ...>   "acc -99",
      ...>   "acc +1",
      ...>   "jmp -4",
      ...>   "acc +6",
      ...> ]
      iex> Day08.part_1(input)
      5

  """
  def part_1(input) do
    input
    |> Enum.map(&parse_instruction/1)
    |> Enum.with_index()
    |> execute_instructions(0, 0, [])
    |> elem(1)
  end

  @doc """
  Fix the input and return the accumulator.

      iex> input = [
      ...>   "nop +0",
      ...>   "acc +1",
      ...>   "jmp +4",
      ...>   "acc +3",
      ...>   "jmp -3",
      ...>   "acc -99",
      ...>   "acc +1",
      ...>   "jmp -4",
      ...>   "acc +6",
      ...> ]
      iex> Day08.part_2(input)
      8

  """
  def part_2(input) do
    instructions =
      input
      |> Enum.map(&parse_instruction/1)
      |> Enum.with_index()

    instructions
    |> Enum.filter(&should_toggle?/1)
    |> Enum.unzip()
    |> elem(1)
    |> Enum.reduce_while(nil, &check_instructions(instructions, &1, &2))
  end

  defp should_toggle?({{"nop", _}, _}), do: true
  defp should_toggle?({{"jmp", _}, _}), do: true
  defp should_toggle?(_), do: false

  defp check_instructions(instructions, index, _acc) do
    instructions = List.update_at(instructions, index, &toggle_instruction/1)

    case execute_instructions(instructions, 0, 0, []) do
      {:ok, acc} -> {:halt, acc}
      {:error, _acc} -> {:cont, nil}
    end
  end

  defp toggle_instruction({{"nop", i}, index}), do: {{"jmp", i}, index}
  defp toggle_instruction({{"jmp", i}, index}), do: {{"nop", i}, index}

  @doc """
  Execute an instruction from a list of instructions.

  ## Instructions

  * `acc` - increases or decreases a single global value called the accumulator
    by the value given in the argument. For example, acc +7 would increase the
    accumulator by 7. The accumulator starts at 0. After an acc instruction, the
    instruction immediately below it is executed next.

  * `jmp` - jumps to a new instruction relative to itself. The next instruction
    to execute is found using the argument as an offset from the jmp
    instruction; for example, jmp +2 would skip the next instruction, jmp +1
    would continue to the instruction immediately below it, and jmp -20 would
    cause the instruction 20 lines above to be executed next.

  * `nop` - stands for No OPeration - it does nothing. The instruction
    immediately below it is executed next.

  """
  def execute_instructions(instructions, index, acc, executed) do
    cond do
      index in executed ->
        {:error, acc}

      index == Enum.count(instructions) ->
        {:ok, acc}

      true ->
        case Enum.at(instructions, index) do
          {{"nop", _}, _i} -> execute_instructions(instructions, index + 1, acc, [index | executed])
          {{"acc", n}, _i} -> execute_instructions(instructions, index + 1, acc + n, [index | executed])
          {{"jmp", n}, _i} -> execute_instructions(instructions, index + n, acc, [index | executed])
        end
    end
  end

  @doc """
  Parse an instruction string into a tuple.

  ## Example

      iex> Day08.parse_instruction("acc +1")
      {"acc", 1}

      iex> Day08.parse_instruction("jmp -3")
      {"jmp", -3}

  """
  def parse_instruction(instruction_string) do
    [instruction, value] = String.split(instruction_string, " ")
    {instruction, String.to_integer(value)}
  end
end
