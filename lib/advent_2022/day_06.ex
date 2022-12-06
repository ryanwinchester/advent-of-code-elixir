defmodule Advent2022.Day06 do
  @moduledoc """
  --- Day 6: Tuning Trouble ---

  https://adventofcode.com/2022/day/6
  """

  @start_of_signal 4
  @start_of_message 14

  @doc """
  After the rearrangement procedure completes, what crate ends up on top of
  each stack?

  ## Examples

      iex> part_1("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
      7

      iex> part_1("bvwbjplbgvbhsrlpgdmjqwftvncz")
      5

      iex> part_1("nppdvjthqldpwncqszvftbrmjlhg")
      6

      iex> part_1("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
      10

      iex> part_1("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
      11

  """
  def part_1(buffer), do: marker_index(buffer, @start_of_signal)

  @doc """
  After the rearrangement procedure completes, what crate ends up on top of
  each stack?

  ## Examples

      iex> part_2("mjqjpqmgbljsphdztnvjfqwrcgsmlb")
      19

      iex> part_2("bvwbjplbgvbhsrlpgdmjqwftvncz")
      23

      iex> part_2("nppdvjthqldpwncqszvftbrmjlhg")
      23

      iex> part_2("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
      29

      iex> part_2("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
      26

  """
  def part_2(buffer), do: marker_index(buffer, @start_of_message)

  defp marker_index(buffer, num_uniq) do
    buffer
    |> String.codepoints()
    |> Enum.with_index()
    |> Enum.chunk_every(num_uniq, 1)
    |> get_marker_index()
  end

  defp get_marker_index([check | rest]) do
    if Enum.uniq_by(check, &elem(&1, 0)) == check do
      {_, i} = List.last(check)
      i + 1
    else
      get_marker_index(rest)
    end
  end
end
