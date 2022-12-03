defmodule Advent2022.Day03 do
  @moduledoc """
  --- Day 3: Rucksack Reorganization ---

  https://adventofcode.com/2022/day/3
  """

  @doc """
  Find the item type that appears in both compartments of each rucksack.
  What is the sum of the priorities of those item types?

  ## Example

      iex> rucksacks = ~w[
      ...>   vJrwpWtwJgWrhcsFMMfFFhFp
      ...>   jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      ...>   PmmdzqPrVvPwwTWBwg
      ...>   wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ...>   ttgJtRGJQctTZtZT
      ...>   CrZsJsPPZsGzwwsLwLmpwMDw
      ...> ]
      iex> part_1(rucksacks)
      157

  """
  def part_1(rucksacks) do
    Enum.map(rucksacks, fn rucksack ->
      rucksack
      |> String.split_at(div(byte_size(rucksack), 2))
      |> Tuple.to_list()
      |> Enum.map(&String.split(&1, "", trim: true))
      |> intersect_items()
      |> Enum.reduce(0, &(priority(&1) + &2))
    end) |> Enum.sum()
  end

  @doc """
  Find the item type that corresponds to the badges of each three-Elf group.
  What is the sum of the priorities of those item types?

  ## Example

      iex> rucksacks = ~w[
      ...>   vJrwpWtwJgWrhcsFMMfFFhFp
      ...>   jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
      ...>   PmmdzqPrVvPwwTWBwg
      ...>   wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
      ...>   ttgJtRGJQctTZtZT
      ...>   CrZsJsPPZsGzwwsLwLmpwMDw
      ...> ]
      iex> part_2(rucksacks)
      70

  """
  def part_2(rucksacks) do
    rucksacks
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.chunk_every(3)
    |> Enum.map(fn group ->
      group
      |> intersect_items()
      |> Enum.reduce(0, &(priority(&1) + &2))
    end)
    |> Enum.sum()
  end

  defp intersect_items(items) do
    items
    |> Enum.reduce(&MapSet.intersection(MapSet.new(&1), MapSet.new(&2)))
    |> MapSet.to_list()
  end

  defp priority(<<c>>) when c in ?a..?z, do: c - 96
  defp priority(<<c>>) when c in ?A..?Z, do: c - 38
end
