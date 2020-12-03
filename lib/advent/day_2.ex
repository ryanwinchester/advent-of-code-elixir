defmodule Advent.Day2 do
  @doc """
  Count valid passwords with the requirements.

  ## Examples

      iex> input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
      iex> Advent.Day2.part_1(input)
      2

  """
  def part_1(inputs) do
    inputs
    |> Enum.map(&capture_matches/1)
    |> Enum.filter(&check_password_part_1/1)
    |> Enum.count()
  end

  @doc """
  Count valid passwords with the actually correct requirements.

  ## Examples

      iex> input = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"]
      iex> Advent.Day2.part_2(input)
      1

  """
  def part_2(inputs) do
    inputs
    |> Enum.map(&capture_matches/1)
    |> Enum.filter(&check_password_part_2/1)
    |> Enum.count()
  end

  defp capture_matches(input) do
    Regex.named_captures(
      ~r/^(?<min>\d+)-(?<max>\d+) (?<letter>[a-zA-Z]): (?<pass>[a-zA-Z]+)$/,
      input
    )
  end

  defp check_password_part_1(input) do
    %{
      "min" => min,
      "max" => max,
      "letter" => letter,
      "pass" => password
    } = input

    min = String.to_integer(min)
    max = String.to_integer(max)

    split_count = String.split(password, letter) |> Enum.count()

    (split_count - 1) in min..max
  end

  defp check_password_part_2(input) do
    %{
      "min" => position_1,
      "max" => position_2,
      "letter" => letter,
      "pass" => password
    } = input

    position_1 = String.to_integer(position_1)
    position_2 = String.to_integer(position_2)

    match1? = String.at(password, position_1 - 1) == letter
    match2? = String.at(password, position_2 - 1) == letter

    match1? != match2?
  end
end
