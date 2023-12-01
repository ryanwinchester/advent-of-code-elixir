defmodule Advent2023.Day01 do
  @moduledoc """
  --- Day 1: Trebuchet?! ---

  https://adventofcode.com/2023/day/1

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
  """

  @doc """
  Consider your entire calibration document.
  What is the sum of all of the calibration values?

  ## Examples

      iex> input = ~w[
      ...>   1abc2
      ...>   pqr3stu8vwx
      ...>   a1b2c3d4e5f
      ...>   treb7uchet
      ...> ]
      iex> part_1(input)
      142

  """
  def part_1(input) do
    input
    |> Enum.map(&Integer.undigits([first_digit(&1), first_digit(binary_reverse(&1))]))
    |> Enum.sum()
  end

  defp first_digit(<<d, _rest::binary>>) when d in ?0..?9, do: d - ?0
  defp first_digit(<<_, rest::binary>>), do: first_digit(rest)

  defp binary_reverse(binary) do
    binary
    |> :binary.decode_unsigned(:little)
    |> :binary.encode_unsigned(:big)
  end

  @doc """
  Consider your entire calibration document.
  What is the sum of all of the calibration values?

  ## Examples

      iex> input = ~w[
      ...>    two1nine
      ...>    eightwothree
      ...>    abcone2threexyz
      ...>    xtwone3four
      ...>    4nineeightseven2
      ...>    zoneight234
      ...>    7pqrstsixteen
      ...> ]
      iex> part_2(input)
      281

  """
  def part_2(input) do
    Enum.reduce(input, 0, &(first_last(&1) + &2))
  end

  # Save the first and last digit as we recurse through the string.
  # Gotcha: the last letter of one number word could be the start of another number word.
  # I concat them to `rest` when that is the case, and continue the recursion.
  defp first_last(string, first \\ nil, last \\ nil)
  defp first_last("one" <> rest, f, _l), do: first_last("e" <> rest, f || 1, 1)
  defp first_last("two" <> rest, f, _l), do: first_last("o" <> rest, f || 2, 2)
  defp first_last("three" <> rest, f, _l), do: first_last("e" <> rest, f || 3, 3)
  defp first_last("four" <> rest, f, _l), do: first_last(rest, f || 4, 4)
  defp first_last("five" <> rest, f, _l), do: first_last("e" <> rest, f || 5, 5)
  defp first_last("six" <> rest, f, _l), do: first_last(rest, f || 6, 6)
  defp first_last("seven" <> rest, f, _l), do: first_last(rest, f || 7, 7)
  defp first_last("eight" <> rest, f, _l), do: first_last("t" <> rest, f || 8, 8)
  defp first_last("nine" <> rest, f, _l), do: first_last("e" <> rest, f || 9, 9)
  defp first_last(<<d, s::binary>>, f, _) when d in ?0..?9, do: first_last(s, f || d - ?0, d - ?0)
  defp first_last(<<_::binary-1, rest::binary>>, first, last), do: first_last(rest, first, last)
  defp first_last(<<>>, first, last), do: Integer.undigits([first, last])
end
