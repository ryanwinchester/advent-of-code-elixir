defmodule Advent2022.Day06 do
  @moduledoc """
  --- Day 6: Tuning Trouble ---

  https://adventofcode.com/2022/day/6

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @start_of_signal 4
  @start_of_message 14

  @doc """
  How many characters need to be processed before the first start-of-packet
  marker is detected?

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
  How many characters need to be processed before the first start-of-message
  marker is detected?

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

  defp marker_index(buffer, marker_length) do
    buffer
    |> String.codepoints()
    |> Enum.chunk_every(marker_length, 1)
    |> get_marker_index()
  end

  defp get_marker_index([check | rest], index \\ 0) do
    if Enum.uniq(check) == check do
      length(check) + index
    else
      get_marker_index(rest, index + 1)
    end
  end
end
