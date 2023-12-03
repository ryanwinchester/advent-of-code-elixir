defmodule Advent2023.Day03Parser do
  @moduledoc """
  Parser for Day 03.
  """

  @doc """
  Recursive binary pattern-matching parser for Day 3.

  ## Example

      iex> input = ~S'''
      ...>   467..114..
      ...>   ...*......
      ...>   ..35..633.
      ...>   ......#...
      ...>   617*......
      ...>   .....+.58.
      ...>   ..592.....
      ...>   ......755.
      ...>   ...$.*....
      ...>   .664.598..
      ...>   '''
      iex> input(input)
      %{
        parts: %{
          {0, 0..2} => 467,
          {0, 5..7} => 114,
          {2, 2..3} => 35,
          {2, 6..8} => 633,
          {4, 0..2} => 617,
          {5, 7..8} => 58,
          {6, 2..4} => 592,
          {7, 6..8} => 755,
          {9, 1..3} => 664,
          {9, 5..7} => 598
        },
        symbols: %{
          {1, 3} => "*",
          {3, 6} => "#",
          {4, 3} => "*",
          {5, 5} => "+",
          {8, 3} => "$",
          {8, 5} => "*"
        }
      }

  """
  def input(input) do
    input(input, nil, 0, 0, %{parts: %{}, symbols: %{}})
  end

  defp input(string, current_digit, x, y, acc)

  ## Dots
  defp input(<<".", rest::binary>>, nil, x, y, acc), do: input(rest, nil, x, y + 1, acc)
  defp input(<<".", rest::binary>>, d, x, y, acc) do
    input(rest, nil, x, y + 1, part_end(acc, d, x, y - 1))
  end

  ## Newlines
  defp input(<<"\n", rest::binary>>, nil, x, _y, acc), do: input(rest, nil, x + 1, 0, acc)
  defp input(<<"\n", rest::binary>>, d, x, y, acc) do
    input(rest, nil, x + 1, 0, part_end(acc, d, x, y - 1))
  end

  ## Digits
  defp input(<<d, rest::binary>>, nil, x, y, acc) when d in ?0..?9 do
    input(rest, {d - ?0, y}, x, y + 1, acc)
  end
  defp input(<<d, rest::binary>>, {d0, y0}, x, y, acc) when d in ?0..?9 do
    input(rest, {d0 * 10 + d - ?0, y0}, x, y + 1, acc)
  end

  ## Symbols
  defp input(<<s::binary-1, rest::binary>>, nil, x, y, acc) do
    input(rest, nil, x, y + 1, symbol(acc, s, x, y))
  end
  defp input(<<s::binary-1, rest::binary>>, d, x, y, acc) do
    acc = part_end(acc, d, x, y - 1) |> symbol(s, x, y)
    input(rest, nil, x, y + 1, acc)
  end

  ## Finished
  defp input(<<>>, nil, _x, _y, acc), do: acc
  defp input(<<>>, d, x, y, acc), do: part_end(acc, d, x, y - 1)

  ## Helpers

  defp part_end(acc, {d, y0}, x, y) do
    put_in(acc, [:parts, {x, y0..y}], d)
  end

  defp symbol(acc, s, x, y) do
    put_in(acc, [:symbols, {x, y}], s)
  end
end
