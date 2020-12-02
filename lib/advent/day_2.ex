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
      ~r/^(?<rs>\d+)-(?<re>\d+) (?<l>[a-zA-Z]): (?<pass>[a-zA-Z]+)$/,
      input
    )
  end

  defp check_password_part_1(input) do
    %{
      "rs" => range_start,
      "re" => range_end,
      "l" => letter,
      "pass" => password
    } = input

    range_start = String.to_integer(range_start)
    range_end = String.to_integer(range_end)

    frequencies =
      password
      |> String.split("")
      |> Enum.frequencies()
      |> Map.get(letter, 0)

    frequencies in range_start..range_end
  end

  defp check_password_part_2(input) do
    %{
      "rs" => position_1,
      "re" => position_2,
      "l" => letter,
      "pass" => password
    } = input

    position_1 = String.to_integer(position_1)
    position_2 = String.to_integer(position_2)

    match1? = String.at(password, position_1 - 1) == letter
    match2? = String.at(password, position_2 - 1) == letter

    match1? != match2?
  end
end
