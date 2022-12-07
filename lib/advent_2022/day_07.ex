defmodule Advent2022.Day07 do
  @moduledoc """
  --- Day 7: No Space Left On Device ---

  https://adventofcode.com/2022/day/7

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @total_space 70_000_000
  @space_required 30_000_000

  @doc """
  Find all of the directories with a total size of at most `100_000`.
  What is the sum of the total sizes of those directories?

  ## Examples

      iex> input = %{
      ...>   ["/"] => [
      ...>     {:dir, "/d"},
      ...>     {:file, "c.dat", 8_504_156},
      ...>     {:file, "b.txt", 14_848_514},
      ...>     {:dir, "/a"}
      ...>   ],
      ...>   ["/", "a"] => [
      ...>     {:file, "h.lst", 62596},
      ...>     {:file, "g", 2557},
      ...>     {:file, "f", 29116},
      ...>     {:dir, "/a/e"}
      ...>   ],
      ...>   ["/", "a", "e"] => [
      ...>     {:file, "i", 584}
      ...>   ],
      ...>   ["/", "d"] => [
      ...>     {:file, "k", 7_214_296},
      ...>     {:file, "d.ext", 5_626_152},
      ...>     {:file, "d.log", 8_033_020},
      ...>     {:file, "j", 4_060_174}
      ...>   ]
      ...> }
      iex> part_1(input)
      95437

  """
  def part_1(filesystem) do
    filesystem
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

      iex> input = %{
      ...>   ["/"] => [
      ...>     {:dir, "/d"},
      ...>     {:file, "c.dat", 8_504_156},
      ...>     {:file, "b.txt", 14_848_514},
      ...>     {:dir, "/a"}
      ...>   ],
      ...>   ["/", "a"] => [
      ...>     {:file, "h.lst", 62596},
      ...>     {:file, "g", 2557},
      ...>     {:file, "f", 29116},
      ...>     {:dir, "/a/e"}
      ...>   ],
      ...>   ["/", "a", "e"] => [
      ...>     {:file, "i", 584}
      ...>   ],
      ...>   ["/", "d"] => [
      ...>     {:file, "k", 7_214_296},
      ...>     {:file, "d.ext", 5_626_152},
      ...>     {:file, "d.log", 8_033_020},
      ...>     {:file, "j", 4_060_174}
      ...>   ]
      ...> }
      iex> part_2(input)
      24933642

  """
  def part_2(filesystem) do
    file_sizes = sum_files_per_dir(filesystem)
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
      path
      |> Enum.reverse()
      |> update_full_path_totals(total, path_totals)
    end)
  end

  # Recursively walks up the `path` and updates `total` for each, until
  # we're done (i.e. path is empty: `[]`).
  defp update_full_path_totals([], _, path_totals), do: path_totals

  defp update_full_path_totals([_ | rest] = path, total, path_totals) do
    path_totals = Map.update(path_totals, path, total, &(&1 + total))
    update_full_path_totals(rest, total, path_totals)
  end
end
