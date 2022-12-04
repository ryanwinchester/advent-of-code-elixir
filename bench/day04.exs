sections =
  "../test/support/inputs/2022/day-04.txt"
  |> Path.expand(__DIR__)
  |> File.read!()
  |> String.split("\n", trim: true)
  |> Enum.map(fn pair ->
    pair
    |> String.split(",")
    |> Enum.map(fn range_str ->
      [a, b] = String.split(range_str, "-")
      Range.new(String.to_integer(a), String.to_integer(b))
    end)
    |> List.to_tuple()
  end)


Benchee.run(
  %{
    "range in" => fn ->
      Enum.reduce(sections, 0, fn {a, b}, count ->
        cond do
          a.first in b and a.last in b -> count + 1
          b.first in a and b.last in a -> count + 1
          true -> count
        end
      end)
    end,

    "compare fist-last" => fn ->
      Enum.reduce(sections, 0, fn {a, b}, count ->
        cond do
          a.first >= b.first and a.last <= b.last -> count + 1
          b.first >= a.first and b.last <= a.last -> count + 1
          true -> count
        end
      end)
    end
  }
)
