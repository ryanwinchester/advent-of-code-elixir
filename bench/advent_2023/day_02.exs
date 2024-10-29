defmodule DiscordFriend do
  def parser(str) do
    str
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split(": ", trim: true)
      |> Enum.drop(1)
      |> hd
      |> (&Regex.scan(~r/(\d+)\s*([a-zA-Z]+)/, &1)).()
    end)
  end

  def solution1(map) do
    map
    |> Enum.with_index()
    |> Enum.reduce(0, fn {line, idx}, acc ->
      line
      |> is_game_possible
      |> Enum.all?()
      |> if(do: acc + idx + 1, else: acc)
    end)
  end


  def is_game_possible(color_map) do
    color_map
    |> Enum.map(fn list ->
      color = Enum.at(list, 2)
      amount = String.to_integer(Enum.at(list, 1))

      case color do
        "red" when amount > 12 -> false
        "green" when amount > 13 -> false
        "blue" when amount > 14 -> false
        _ -> true
      end
    end)
  end

  def solution2(map) do
    map
    |> Enum.map(fn line ->
      line
      |> min_color_possible
      |> Enum.product()
    end)
    |> Enum.sum()
  end

def min_color_possible(color_map) do
    color_map
    |> Enum.reduce([0, 0, 0], fn line, acc ->
      color = Enum.at(line, 2)
      amount = String.to_integer(Enum.at(line, 1))

      red = Enum.at(acc, 0)
      green = Enum.at(acc, 1)
      blue = Enum.at(acc, 2)

      case color do
        "red" when amount > red -> [amount | tl(acc)]
        "green" when amount > green -> [red, amount, blue]
        "blue" when amount > blue -> [red, green, amount]
        _ -> acc
      end
    end)
  end
end


# ------------------------------------------------------------------------------
# Benchmarks
# ------------------------------------------------------------------------------

input =
  "../../test/support/inputs/advent_2023/02.txt"
  |> Path.expand(__DIR__)
  |> File.read!()

Benchee.run(
  %{
    # "discord part 1" => fn ->
    #   input
    #   |> DiscordFriend.parser()
    #   |> DiscordFriend.solution1()
    # end,
    # "ryan part 1" => fn ->
    #   {:ok, [input], _, _, _, _} = Advent2023.Day02Parser.input(input)
    #   Advent2023.Day02.part_1(input)
    # end
    "discord part 2" => fn ->
      input
      |> DiscordFriend.parser()
      |> DiscordFriend.solution2()
    end,
    "ryan part 2" => fn ->
      {:ok, [input], _, _, _, _} = Advent2023.Day02Parser.input(input)
      Advent2023.Day02.part_2(input)
    end
  },
  time: 5,
  memory_time: 2
)