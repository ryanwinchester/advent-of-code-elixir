defmodule Advent2022.Day03 do
  @moduledoc """
  --- Day 3: Rucksack Reorganization ---

  https://adventofcode.com/2022/day/3

  **Note:** I parse my input in the test setup because sharing input parsing
  every time is boring and nobody cares to see it (at least I don't).
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
    rucksacks
    |> Enum.map(fn rucksack ->
      rucksack
      |> to_compartments()
      |> common_items()
      |> sum_priorities()
    end)
    |> Enum.sum()
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
    |> to_groups()
    |> Enum.map(&(common_items(&1) |> sum_priorities()))
    |> Enum.sum()
  end

  defp to_compartments(rucksack) do
    rucksack
    |> String.split_at(div(byte_size(rucksack), 2))
    |> Tuple.to_list()
    |> Enum.map(&String.codepoints/1)
  end

  defp to_groups(rucksack) do
    rucksack
    |> Enum.map(&String.codepoints/1)
    |> Enum.chunk_every(3)
  end

  defp common_items(items) do
    items
    |> Enum.reduce(&MapSet.intersection(MapSet.new(&1), MapSet.new(&2)))
    |> MapSet.to_list()
  end

  defp sum_priorities(items), do: Enum.reduce(items, 0, &(to_priority(&1) + &2))

  defp to_priority(<<c>>) when c in ?a..?z, do: c - 96
  defp to_priority(<<c>>) when c in ?A..?Z, do: c - 38
end
