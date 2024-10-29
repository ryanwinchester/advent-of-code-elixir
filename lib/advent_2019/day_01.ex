defmodule Advent2019.Day01 do
  @moduledoc """
  --- Day 1: The Tyranny of the Rocket Equation ---

  https://adventofcode.com/2019/day/1
  """

  @doc """
  What is the sum of the fuel requirements for all of the modules on your
  spacecraft?

  ## Example

      iex> Day01.part_1([12, 14, 1969, 100_756])
      34_241

  """
  def part_1(masses) do
    Enum.reduce(masses, 0, &(fuel_by_mass(&1) + &2))
  end

  @doc """
  What is the sum of the fuel requirements for all of the modules on your
  spacecraft when also taking into account the mass of the added fuel?

  (Calculate the fuel requirements for each module separately, then add them all
  up at the end.)

  ## Example

      iex> Day01.part_2([12, 14, 1969, 100_756])
      51_316

  """
  def part_2(masses) do
    Enum.reduce(masses, 0, &(fuel_by_mass_including_fuel(&1) + &2))
  end

  @doc """
  Get the fuel required to launch a given mass.

  ## Examples

      iex> Day01.fuel_by_mass(12)
      2

      iex> Day01.fuel_by_mass(14)
      2

      iex> Day01.fuel_by_mass(1969)
      654

      iex> Day01.fuel_by_mass(100_756)
      33_583

  """
  def fuel_by_mass(mass) when mass <= 8, do: 0
  def fuel_by_mass(mass), do: div(mass, 3) - 2

  @doc """
  Get the fuel required to launch a given mass, including the mass of the fuel.

  ## Examples

      iex> Day01.fuel_by_mass_including_fuel(12)
      2

      iex> Day01.fuel_by_mass_including_fuel(14)
      2

      iex> Day01.fuel_by_mass_including_fuel(1969)
      966

      iex> Day01.fuel_by_mass_including_fuel(100_756)
      50_346

  """
  def fuel_by_mass_including_fuel(mass, acc \\ 0) do
    case fuel_by_mass(mass) do
      0 -> acc
      fuel -> fuel_by_mass_including_fuel(fuel, acc + fuel)
    end
  end
end
