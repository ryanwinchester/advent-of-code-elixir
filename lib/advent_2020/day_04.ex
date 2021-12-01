defmodule Advent2020.Day04 do
  @moduledoc """
  --- Day 4: Passport Processing ---
  https://adventofcode.com/2020/day/4
  """

  @required_fields ~w(byr iyr eyr hgt hcl ecl pid)

  @doc """
  Count valid passports in a batch text file.

  ## Example

      iex> Day04.part_1(input)
      2

  """
  def part_1(input) do
    input
    |> String.split("\n\n")
    |> Enum.filter(&validate_required(&1, @required_fields))
    |> Enum.count()
  end

  @doc """
  Count valid passports (with data validation) in a batch text file.

  ## Example

      iex> Day04.part_1(input)
      4

  """
  def part_2(input) do
    input
    |> String.split("\n\n")
    |> Enum.filter(&validate_passport/1)
    |> Enum.count()
  end

  defp validate_passport(passport_string) do
    validate_required(passport_string, @required_fields) and
      validate_fields(passport_string)
  end

  defp validate_required(passport_string, required_fields) do
    Enum.all?(required_fields, &Regex.match?(~r/(^|\s)#{&1}:/, passport_string))
  end

  defp validate_fields(passport_string) do
    passport_string
    |> String.split(~r/\s/, trim: true)
    |> Enum.all?(&validate_field/1)
  end

  def validate_field("byr:" <> value), do: validate_year_between(value, {1920, 2002})
  def validate_field("iyr:" <> value), do: validate_year_between(value, {2010, 2020})
  def validate_field("eyr:" <> value), do: validate_year_between(value, {2020, 2030})
  def validate_field("hgt:" <> value), do: validate_height(value)
  def validate_field("hcl:" <> value), do: Regex.match?(~R/^#[0-9a-f]{6}$/, value)
  def validate_field("ecl:" <> value), do: value in ~w(amb blu brn gry grn hzl oth)
  def validate_field("pid:" <> value), do: Regex.match?(~R/^[0-9]{9}$/, value)
  def validate_field("cid:" <> _value), do: true
  def validate_field(field), do: raise("Invalid field: #{field}")

  defp validate_height(height_string) do
    case Integer.parse(height_string) do
      {n, "cm"} -> n >= 150 and n <= 193
      {n, "in"} -> n >= 29 and n <= 76
      _ -> false
    end
  end

  defp validate_year_between(year_string, {min, max}) do
    case Integer.parse(year_string) do
      {year, ""} -> year >= min and year <= max
      _ -> false
    end
  end
end
