defmodule Advent2022.Day07Parser do
  @moduledoc """
  Recursive parser for Day 07.

  ### Input

      $ cd /
      $ ls
      dir a
      14848514 b.txt
      8504156 c.dat
      dir d
      $ cd a
      $ ls
      dir e
      29116 f
      2557 g
      62596 h.lst
      $ cd e
      $ ls
      584 i
      $ cd ..
      $ cd ..
      $ cd d
      $ ls
      4060174 j
      8033020 d.log
      5626152 d.ext
      7214296 k

  ### Output

      %{
        ["/"] => [
          {:dir, "/d"},
          {:file, "c.dat", 8_504_156},
          {:file, "b.txt", 14_848_514},
          {:dir, "/a"}
        ],
        ["/", "a"] => [
          {:file, "h.lst", 62596},
          {:file, "g", 2557},
          {:file, "f", 29116},
          {:dir, "/a/e"}
        ],
        ["/", "a", "e"] => [
          {:file, "i", 584}
        ],
        ["/", "d"] => [
          {:file, "k", 7_214_296},
          {:file, "d.ext", 5_626_152},
          {:file, "d.log", 8_033_020},
          {:file, "j", 4_060_174}
        ]
      }

  """

  @n "\n"

  @doc """
  Walk recursively through the commands, files, and directories.
  This is the starting point.
  """
  def input(<<"$ cd /", @n, rest::binary>>) do
    commands(rest, ["/"], %{})
  end

  # ----------------------------------------------------------------------------
  # Commands
  # ----------------------------------------------------------------------------

  # This is the end of the string. Nothing more to parse.
  defp commands(eos, _, acc) when eos in [@n, ""], do: acc

  # Going up one directory.
  defp commands(<<"$ cd ..", @n, rest::binary>>, path, acc) do
    commands(rest, tl(path), acc)
  end

  # Going in to the specified directory.
  defp commands(<<"$ cd ", rest::binary>>, path, acc) do
    [dir, rest] = String.split(rest, @n, parts: 2)
    commands(rest, [dir | path], acc)
  end

  # Listing the contents of the directory.
  defp commands(<<"$ ls", @n, rest::binary>>, path, acc) do
    files(rest, path, acc)
  end

  # ----------------------------------------------------------------------------
  # Files & Dirs
  # ----------------------------------------------------------------------------

  # No more files, back to commands.
  defp files(<<"$", _rest::binary>> = commands, path, acc) do
    commands(commands, path, acc)
  end

  # For each file and directory listed, add it to the map under current path.
  defp files(files, path, acc) do
    case String.split(files, @n, parts: 2, trim: true) do
      [file, rest] ->
        file = parse_file(file, path)
        files(rest, path, Map.update(acc, path_key(path), [file], &[file | &1]))

      # There are no other parts if we are at the end of the input.
      # We can end the recursion here.
      [file] ->
        file = parse_file(file, path)
        Map.update(acc, path_key(path), [file], &[file | &1])
    end
  end

  # Parse the file or dir into a tuple.
  #  * {:file, name, size}
  #  * {:dir, name}
  defp parse_file(file, path) do
    case String.split(file, " ") do
      ["dir", name] -> {:dir, path_key(path) |> Path.join(name)}
      [size, name] -> {:file, name, String.to_integer(size)}
    end
  end

  defp path_key(path), do: Enum.reverse(path)
end
