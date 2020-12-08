defmodule Advent.Day07 do
  @moduledoc """
  --- Day 7: Handy Haversacks ---
  https://adventofcode.com/2020/day/7
  """

  @doc """
  Determine how many bag colors can eventually contain at least one shiny gold
  bag.

  ## Example

      iex> input = [
      ...>   "light red bags contain 1 bright white bag, 2 muted yellow bags.",
      ...>   "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
      ...>   "bright white bags contain 1 shiny gold bag.",
      ...>   "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
      ...>   "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
      ...>   "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
      ...>   "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
      ...>   "faded blue bags contain no other bags.",
      ...>   "dotted black bags contain no other bags.",
      ...> ]
      iex> Day07.part_1(input)
      4

  """
  def part_1(input) do
    input
    |> parse_rules()
    |> get_containers("shiny gold")
    |> Enum.uniq()
    |> Enum.count()
  end

  @doc """

  ## Example

      iex> input = [
      ...>   "light red bags contain 1 bright white bag, 2 muted yellow bags.",
      ...>   "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
      ...>   "bright white bags contain 1 shiny gold bag.",
      ...>   "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
      ...>   "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
      ...>   "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
      ...>   "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
      ...>   "faded blue bags contain no other bags.",
      ...>   "dotted black bags contain no other bags.",
      ...> ]
      iex> Day07.part_2(input)
      32

      iex> input = [
      ...>   "shiny gold bags contain 2 dark red bags.",
      ...>   "dark red bags contain 2 dark orange bags.",
      ...>   "dark orange bags contain 2 dark yellow bags.",
      ...>   "dark yellow bags contain 2 dark green bags.",
      ...>   "dark green bags contain 2 dark blue bags.",
      ...>   "dark blue bags contain 2 dark violet bags.",
      ...>   "dark violet bags contain no other bags.",
      ...> ]
      iex> Day07.part_2(input)
      126

  """
  def part_2(input) do
    input
    |> parse_rules()
    |> count_contents("shiny gold")
  end

  defp count_contents(rules, bag) do
    rules
    |> Map.get(bag, [])
    |> Enum.reduce(0, fn {n, container}, total ->
      total + n + n * count_contents(rules, container)
    end)
  end

  @doc """
  Parse a list of rules (as sentences).

  ## Example


      iex> rules = [
      ...>   "light red bags contain 1 bright white bag, 2 muted yellow bags.",
      ...>   "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
      ...>   "bright white bags contain 1 shiny gold bag.",
      ...>   "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
      ...>   "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
      ...>   "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
      ...>   "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
      ...>   "faded blue bags contain no other bags.",
      ...>   "dotted black bags contain no other bags.",
      ...> ]
      iex> Day07.parse_rules(rules)
      %{
        "light red"    => [{1, "bright white"}, {2, "muted yellow"}],
        "dark orange"  => [{3, "bright white"}, {4, "muted yellow"}],
        "bright white" => [{1, "shiny gold"}],
        "muted yellow" => [{2, "shiny gold"}, {9, "faded blue"}],
        "shiny gold"   => [{1, "dark olive"}, {2, "vibrant plum"}],
        "dark olive"   => [{3, "faded blue"}, {4, "dotted black"}],
        "vibrant plum" => [{5, "faded blue"}, {6, "dotted black"}],
        "faded blue"   => [],
        "dotted black" => [],
      }

  """
  def parse_rules(rules) do
    rules
    |> Enum.map(&parse_rule/1)
    |> Enum.into(%{})
  end

  @doc """
  Parse a rule.

  ## Example

      iex> Day07.parse_rule("light red bags contain 1 bright white bag, 2 muted yellow bags.")
      {"light red", [{1, "bright white"}, {2, "muted yellow"}]}

      iex> Day07.parse_rule("dotted black bags contain no other bags.")
      {"dotted black", []}

  """
  def parse_rule(rule) do
    [bag, contents] =
      rule
      |> String.replace(~r/ bags?\.?/, "")
      |> String.split(" contain ")

    contents =
      case contents do
        "no other" ->
          []

        contents ->
          contents
          |> String.split(", ", trim: true)
          |> Enum.map(&Integer.parse/1)
          |> Enum.map(fn {n, colour} -> {n, String.trim_leading(colour)} end)
      end

    {bag, contents}
  end

  defp get_containers(rules, bag) do
    Enum.reduce(rules, [], fn {container, contents}, acc ->
      if contains_bag?(contents, bag) do
        [container | acc] ++ get_containers(rules, container)
      else
        acc
      end
    end)
  end

  defp contains_bag?(contents, bag) do
    Enum.any?(contents, fn
      {_n, ^bag} -> true
      _ -> false
    end)
  end
end
