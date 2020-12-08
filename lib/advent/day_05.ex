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
    <<n::10>> =
      for <<c::binary-size(1) <- boarding_pass>>, into: <<>> do
        cond do
          c in ~w(F L) -> <<0::1>>
          c in ~w(B R) -> <<1::1>>
        end
      end

    n
  end
end
