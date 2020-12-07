defmodule Advent.Day05 do
  @moduledoc """
  --- Day 5: Binary Boarding ---
  https://adventofcode.com/2020/day/5
  """

  @doc """
  Gets the highest seat ID from a list of boarding passes.

  ## Example

      iex> input = [
      ...>   "FBFBBFFRLR",
      ...>   "BFFFBBFRRR",
      ...>   "FFFBBBFRRR",
      ...>   "BBFFBBFRLL"
      ...> ]
      iex> Day05.part_1(input)
      820

  """
  def part_1(input) do
    input
    |> Enum.map(&seat_id/1)
    |> Enum.max()
  end

  @doc """
  Find my missing seat.
  """
  def part_2(input) do
    input
    |> Enum.map(&seat_id/1)
    |> Enum.sort()
    |> Enum.reduce_while(:init, &compare_seats/2)
  end

  defp compare_seats(seat_id, :init), do: {:cont, seat_id}

  defp compare_seats(seat_id, prev) do
    if seat_id - prev > 1 do
      {:halt, seat_id - 1}
    else
      {:cont, seat_id}
    end
  end

  @doc """
  ## Examples

      iex> Day05.seat_id("FBFBBFFRLR")
      357

      iex> Day05.seat_id("BFFFBBFRRR")
      567

      iex> Day05.seat_id("FFFBBBFRRR")
      119

      iex> Day05.seat_id("BBFFBBFRLL")
      820

  """
  def seat_id(boarding_pass) do
    row =
      boarding_pass
      |> String.slice(0..6)
      |> find_place(0..127)

    column =
      boarding_pass
      |> String.slice(7..9)
      |> find_place(0..7)

    row * 8 + column
  end

  defp find_place("", [row]), do: row

  defp find_place(<<char::binary-size(1), rest::binary>>, range) do
    polarity =
      cond do
        char in ~w(F L) -> 1
        char in ~w(B R) -> -1
      end

    take = div(Enum.count(range), 2)
    half = Enum.take(range, take * polarity)

    find_place(rest, half)
  end
end
