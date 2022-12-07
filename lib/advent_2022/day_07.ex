defmodule Advent2022.Day07 do
  @moduledoc """
  --- Day 7: No Space Left On Device ---

  https://adventofcode.com/2022/day/7
  """
alias Advent2022.Day07Parser

  @doc """
  Find all of the directories with a total size of at most `100_000`.
  What is the sum of the total sizes of those directories?

  ## Examples

      iex> input = \"""
      ...>   $ cd /
      ...>   $ ls
      ...>   dir a
      ...>   14848514 b.txt
      ...>   8504156 c.dat
      ...>   dir d
      ...>   $ cd a
      ...>   $ ls
      ...>   dir e
      ...>   29116 f
      ...>   2557 g
      ...>   62596 h.lst
      ...>   $ cd e
      ...>   $ ls
      ...>   584 i
      ...>   $ cd ..
      ...>   $ cd ..
      ...>   $ cd d
      ...>   $ ls
      ...>   4060174 j
      ...>   8033020 d.log
      ...>   5626152 d.ext
      ...>   7214296 k
      ...>   \"""
      iex> part_1(input)
      95437

  """
  def part_1(input) do
    input
    |> Day07Parser.commands()
    |> sum_files_per_dir()
    |> Enum.filter(fn {_dir, size} -> size <= 100_000 end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.sum()
  end

  defp sum_files_per_dir(filesystem) do
    Enum.reduce(filesystem, %{}, fn {path, files}, acc ->
      total =
        Enum.reduce(files, 0, fn
          {:dir, _name}, sum -> sum
          {:file, _name, size}, sum -> sum + size
        end)

      # Add the total to every directory in this path.
      Enum.reduce(Path.split(path), acc, fn dir, acc ->
        Map.update(acc, dir, total, &(&1 + total))
      end)
    end)
  end
end
