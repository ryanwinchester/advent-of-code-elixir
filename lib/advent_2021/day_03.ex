defmodule Advent2021.Day03 do
  @moduledoc """
  --- Day 3: Binary Diagnostic ---

  https://adventofcode.com/2021/day/3
  """

  @doc """
  Use the binary numbers in the diagnostic report to calculate the gamma rate
  and epsilon rate, then multiply them together.

  What is the power consumption of the submarine?

  ## Example

      iex> report = [
      ...>   "00100",
      ...>   "11110",
      ...>   "10110",
      ...>   "10111",
      ...>   "10101",
      ...>   "01111",
      ...>   "00111",
      ...>   "11100",
      ...>   "10000",
      ...>   "11001",
      ...>   "00010",
      ...>   "01010"
      ...> ]
      iex> Day03.part_1(report)
      198

  """
  def part_1(report) do
    frequencies = bit_frequencies(report)

    gamma = common_bit_sample(frequencies, :most)
    epsilon = common_bit_sample(frequencies, :least)

    gamma * epsilon
  end

  @doc """
  ...

  ## Example

      iex> report = [
      ...>   "00100",
      ...>   "11110",
      ...>   "10110",
      ...>   "10111",
      ...>   "10101",
      ...>   "01111",
      ...>   "00111",
      ...>   "11100",
      ...>   "10000",
      ...>   "11001",
      ...>   "00010",
      ...>   "01010"
      ...> ]
      iex> Day03.part_2(report)
      230

  """
  def part_2(report) do
    oxygen_gen_rating = common_bit_filter(report, 0, :most)
    c02_scrub_rating = common_bit_filter(report, 0, :least)

    oxygen_gen_rating * c02_scrub_rating
  end

  ## Helpers

  defp common_bit_sample(frequencies, type) when type in [:most, :least] do
    frequencies
    |> Enum.map(&common_bit(&1, type))
    |> Enum.join("")
    |> String.to_integer(2)
  end

  # Filter the values by most or least common bits per position.
  defp common_bit_filter([value], _pos, _type), do: String.to_integer(value, 2)

  defp common_bit_filter(values, pos, type) do
    common_bit =
      values
      |> bit_frequencies()
      |> Enum.at(pos)
      |> common_bit(type)

    values
    |> Enum.filter(&(String.at(&1, pos) == common_bit))
    |> common_bit_filter(pos + 1, type)
  end

  # Get the frequencies of the bits by position.
  defp bit_frequencies(report) do
    report
    |> Enum.map(&String.codepoints/1)
    |> transpose()
    |> Enum.map(&Enum.frequencies/1)
  end

  defp common_bit(%{"1" => c, "0" => c}, :most), do: "1"
  defp common_bit(%{"1" => c, "0" => c}, :least), do: "0"
  defp common_bit(%{"1" => a, "0" => b}, :most), do: if(a > b, do: "1", else: "0")
  defp common_bit(%{"1" => a, "0" => b}, :least), do: if(a < b, do: "1", else: "0")
  defp common_bit(%{} = frequencies, _type), do: Map.keys(frequencies) |> Enum.at(0)

  # Transpose the list.
  defp transpose(rows), do: List.zip(rows) |> Enum.map(&Tuple.to_list/1)
end
