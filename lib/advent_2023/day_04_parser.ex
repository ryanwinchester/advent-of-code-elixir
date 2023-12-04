defmodule Advent2023.Day04Parser do
  @moduledoc """
  Parser for Day 04.
  """

  import NimbleParsec

  @doc """
  Parser combinators for parsing day 4.

  ## Example

      iex> input = ~s'''
      ...>   Card 1: 41 48 83 86 17 | 83 86  6 31 17  9 48 53
      ...>   Card 2: 13 32 20 16 61 | 61 30 68 82 17 32 24 19
      ...>   Card 3:  1 21 53 59 44 | 69 82 63 72 16 21 14  1
      ...>   Card 4: 41 92 73 84 69 | 59 84 76 51 58  5 54 83
      ...>   Card 5: 87 83 26 28 32 | 88 30 70 12 93 22 82 36
      ...>   Card 6: 31 18 13 56 72 | 74 77 10 23 35 67 36 11
      ...>   '''
      iex> input(input)
      {:ok, [
        {[41, 48, 83, 86, 17], [83, 86,  6, 31, 17,  9, 48, 53]},
        {[13, 32, 20, 16, 61], [61, 30, 68, 82, 17, 32, 24, 19]},
        {[ 1, 21, 53, 59, 44], [69, 82, 63, 72, 16, 21, 14,  1]},
        {[41, 92, 73, 84, 69], [59, 84, 76, 51, 58,  5, 54, 83]},
        {[87, 83, 26, 28, 32], [88, 30, 70, 12, 93, 22, 82, 36]},
        {[31, 18, 13, 56, 72], [74, 77, 10, 23, 35, 67, 36, 11]}
      ],
      "", %{}, {7, 294}, 294}

  """
  numbers =
    repeat_while(
      ignore(string(" "))
      |> ignore(optional(string(" ")))
      |> integer(min: 1, max: 2),
      {:not_end, []}
    )

  game =
    ignore(string("Card"))
    |> ignore(string(" "))
    |> ignore(optional(string(" ")))
    |> ignore(optional(string(" ")))
    |> ignore(integer(min: 1, max: 3))
    |> ignore(string(":"))
    |> concat(numbers |> times(5) |> reduce({:list_wrap, []}))
    |> ignore(string(" "))
    |> ignore(string("|"))
    |> concat(numbers |> times(8) |> reduce({:list_wrap, []}))
    |> ignore(optional(string("\n")))
    |> reduce({List, :to_tuple, []})
    |> times(min: 1)

  defparsec :input, game

  defp not_end(<<" |", _::binary>>, context, _, _), do: {:halt, context}
  defp not_end(<<"\n", _::binary>>, context, _, _), do: {:halt, context}
  defp not_end(_, context, _, _), do: {:cont, context}

  defp list_wrap(args), do: args
end
