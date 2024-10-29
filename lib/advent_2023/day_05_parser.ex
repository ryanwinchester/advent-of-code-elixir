defmodule Advent2023.Day05Parser do
  @moduledoc """
  Parser for Day 05.
  """

  @map_categories %{
    "seed-to-soil map:\n" => :soil,
    "soil-to-fertilizer map:\n" => :fertilizer,
    "fertilizer-to-water map:\n" => :water,
    "water-to-light map:\n" => :light,
    "light-to-temperature map:\n" => :temperature,
    "temperature-to-humidity map:\n" => :humidity,
    "humidity-to-location map:\n" => :location
  }

  @maps Map.keys(@map_categories)

  @doc """

  ## Example

      iex> input = ~S'''
      ...>   seeds: 79 14 55 13
      ...>   
      ...>   seed-to-soil map:
      ...>   50 98 2
      ...>   52 50 48
      ...>   
      ...>   soil-to-fertilizer map:
      ...>   0 15 37
      ...>   37 52 2
      ...>   39 0 15
      ...>   
      ...>   fertilizer-to-water map:
      ...>   49 53 8
      ...>   0 11 42
      ...>   42 0 7
      ...>   57 7 4
      ...>   
      ...>   water-to-light map:
      ...>   88 18 7
      ...>   18 25 70
      ...>   
      ...>   light-to-temperature map:
      ...>   45 77 23
      ...>   81 45 19
      ...>   68 64 13
      ...>   
      ...>   temperature-to-humidity map:
      ...>   0 69 1
      ...>   1 0 69
      ...>   
      ...>   humidity-to-location map:
      ...>   60 56 37
      ...>   56 93 4
      ...>   '''
      iex> input(input)
      %{
        seeds: [79, 14, 55, 13],
        soil: [{50, 98, 2}, {52, 50, 48}],
        fertilizer: [{0, 15, 37}, {37, 52, 2}, {39, 0, 15}],
        water: [{49, 53, 8}, {0, 11, 42}, {42, 0, 7}, {57, 7, 4}],
        light: [{88, 18, 7}, {18, 25, 70}],
        temperature: [{45, 77, 23}, {81, 45, 19}, {68, 64, 13}],
        humidity: [{0, 69, 1}, {1, 0, 69}],
        location: [{60, 56, 37}, {56, 93, 4}]
      }

  """
  def input(input) do
    input
    |> String.split("\n\n")
    |> Map.new(&parse/1)
  end

  defp parse("seeds: " <> seeds_input) do
    seeds = String.split(seeds_input) |> Enum.map(&String.to_integer/1)
    {:seeds, seeds}
  end

  for map <- @maps do
    defp parse(unquote(map) <> input) do
      parsed = String.split(input, "\n", trim: true) |> Enum.map(&map_ranges/1)
      {@map_categories[unquote(map)], parsed}
    end
  end

  defp map_ranges(range_input) do
    range_input
    |> String.split()
    |> Enum.map(&String.to_integer/1)
    |> List.to_tuple()
  end
end
