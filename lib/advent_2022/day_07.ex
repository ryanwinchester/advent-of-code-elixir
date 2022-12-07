defmodule Advent2022.Day07 do
  @moduledoc """
  --- Day 7: No Space Left On Device ---

  https://adventofcode.com/2022/day/7
  """

  alias Advent2022.Day07Parser

  @total_space 70_000_000
  @space_required 30_000_000

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
    |> Enum.reduce(0, fn
      {_path, size}, total when size <= 100_000 -> total + size
      {_path, _size}, total -> total
    end)
  end

  @doc """
  Find the smallest directory that, if deleted, would free up enough space on
  the filesystem to run the update.
  What is the total size of that directory?

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
      iex> part_2(input)
      24933642

  """
  def part_2(input) do
    file_sizes = Day07Parser.commands(input) |> sum_files_per_dir()
    free_space = @total_space - file_sizes[["/"]]
    space_to_free = @space_required - free_space

    Enum.reduce(file_sizes, @total_space, fn
      {_path, size}, acc when size >= space_to_free and size < acc -> size
      {_path, _size}, acc -> acc
    end)
  end

  defp sum_files_per_dir(filesystem) do
    Enum.reduce(filesystem, %{}, fn {path, files}, path_totals ->
      total =
        Enum.reduce(files, 0, fn
          {:dir, _name}, sum -> sum
          {:file, _name, size}, sum -> sum + size
        end)

      # Update the totals for every dir in path.
      Path.split(path)
      |> Enum.reverse()
      |> update_full_path_totals(total, path_totals)
    end)
  end

  # Recursively walks up the `path` and updates `total` for each, until
  # we're done (i.e. path is empty: `[]`).
  defp update_full_path_totals([], _, path_totals), do: path_totals

  defp update_full_path_totals(path, total, path_totals) do
    path_totals = Map.update(path_totals, path, total, &(&1 + total))
    update_full_path_totals(tl(path), total, path_totals)
  end
end
