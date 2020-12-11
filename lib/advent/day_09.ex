defmodule Advent.Day09 do
  @moduledoc """
  --- Day 9: Encoding Error ---
  https://adventofcode.com/2020/day/9
  """

  @doc """
  Get the first number which is not the sum of two of the 25 numbers before it.

  ## Example

      iex> input = [
      ...>   "35",
      ...>   "20",
      ...>   "15",
      ...>   "25",
      ...>   "47",
      ...>   "40",
      ...>   "62",
      ...>   "55",
      ...>   "65",
      ...>   "95",
      ...>   "102",
      ...>   "117",
      ...>   "150",
      ...>   "182",
      ...>   "127",
      ...>   "219",
      ...>   "299",
      ...>   "277",
      ...>   "309",
      ...>   "576",
      ...> ]
      iex> Day09.part_1(input, 5)
      127

  """
  def part_1(input, preamble_length \\ 25) do
    input
    |> Enum.map(&String.to_integer/1)
    |> find_invalid_number(preamble_length)
  end

  @doc """
  Get the encryption weakness in your XMAS-encrypted list of numbers.

  ## Example

      iex> input = [
      ...>   "35",
      ...>   "20",
      ...>   "15",
      ...>   "25",
      ...>   "47",
      ...>   "40",
      ...>   "62",
      ...>   "55",
      ...>   "65",
      ...>   "95",
      ...>   "102",
      ...>   "117",
      ...>   "150",
      ...>   "182",
      ...>   "127",
      ...>   "219",
      ...>   "299",
      ...>   "277",
      ...>   "309",
      ...>   "576",
      ...> ]
      iex> Day09.part_2(input, 5)
      62

  """
  def part_2(input, preamble_length \\ 25) do
    numbers = Enum.map(input, &String.to_integer/1)
    invalid_number = find_invalid_number(numbers, preamble_length)

    numbers
    |> Enum.with_index()
    |> Enum.map(fn {_value, index} -> index end)
    |> Enum.reduce_while(:not_found, &find_contiguous_set(&1, &2, numbers, invalid_number))
  end

  defp find_invalid_number(numbers, preamble_length) do
    numbers
    |> Enum.with_index()
    |> Enum.slice(preamble_length, Enum.count(numbers))
    |> Enum.find(&matches?(&1, numbers, preamble_length))
    |> elem(0)
  end

  defp matches?({number, index}, numbers, preamble_length) do
    previous = Enum.slice(numbers, index - preamble_length, preamble_length)

    matches =
      for x <- previous,
          y <- previous,
          x != y, x + y == number,
          do: number

    Enum.count(matches) == 0
  end

  defp find_contiguous_set(index, _acc, numbers, invalid_number) do
    numbers
    |> Enum.slice(index, Enum.count(numbers))
    |> Enum.reduce_while([], &check_set(&1, &2, invalid_number))
    |> handle_check_set_result()
  end

  defp check_set(last_number, acc, invalid_number) do
    acc = [last_number | acc]

    if Enum.sum(acc) == invalid_number do
      {:halt, {:ok, acc}}
    else
      {:cont, acc}
    end
  end

  defp handle_check_set_result({:ok, set}) do
    {min, max} = Enum.min_max(set)
    {:halt, min + max}
  end
  defp handle_check_set_result(_), do: {:cont, :not_found}
end
