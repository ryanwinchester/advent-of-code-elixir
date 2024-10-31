defmodule Advent2019.Day04 do
  @moduledoc """
  --- Day 4: Secure Container ---

  https://adventofcode.com/2019/day/4
  """

  defmodule Password do
    defstruct [
      :value,
      is_six_digits?: false,
      has_double?: false,
      never_decreases?: false,
      valid?: false
    ]

    @doc """
    Create a new password struct (and validate the password).
    """
    def new(password) when is_integer(password) do
      %__MODULE__{value: password}
      |> is_six_digits?()
      |> has_double_and_no_decreasing?()
      |> is_valid?()
    end

    defp is_valid?(password) do
      criteria_values =
        password
        |> Map.take([:in_range?, :is_six_digits?, :has_double?, :never_decreases?])
        |> Map.values()

      %{password | valid?: Enum.reduce(criteria_values, true, &(&1 and &2))}
    end

    defp is_six_digits?(password) do
      %{password | is_six_digits?: password.value in 100_000..999_999}
    end

    defp has_double_and_no_decreasing?(password) do
      password.value
      |> Integer.digits()
      |> has_double_and_no_decreasing?(%{password | never_decreases?: true})
    end

    defp has_double_and_no_decreasing?([], password), do: password

    defp has_double_and_no_decreasing?([a, a | rest], password) do
      has_double_and_no_decreasing?([a | rest], %{password | has_double?: true})
    end

    defp has_double_and_no_decreasing?([a, b | rest], password) when a > b do
      has_double_and_no_decreasing?([b | rest], %{password | never_decreases?: false})
    end

    defp has_double_and_no_decreasing?([_ | rest], password) do
      has_double_and_no_decreasing?(rest, password)
    end
  end

  @doc """
  How many different passwords within the range given in your puzzle input meet
  these criteria?

  ## Examples

      iex> Day04.part_1(111111..111111)
      1

      iex> Day04.part_1(223450..223450)
      0

      iex> Day04.part_1(123788..123789)
      1

  """
  def part_1(range) do
    Enum.reduce(range, 0, fn password, count ->
      if Password.new(password).valid?, do: count + 1, else: count
    end)
  end
end
