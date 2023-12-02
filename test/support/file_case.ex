defmodule Advent.FileCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp day_string(day), do: String.pad_leading(to_string(day), 2, "0")

      defp load_answers({year, day}) do
        {answers, []} = Code.eval_file("../support/answers/advent_#{year}/answers.exs", __DIR__)
        Map.fetch!(answers, day)
      end

      defp load_input({year, day}) do
        file = Path.expand("../support/inputs/advent_#{year}/#{day_string(day)}.txt", __DIR__)

        if File.exists?(file) do
          File.read!(file)
        else
          System.fetch_env!("INPUT_#{year}_#{day_string(day)}")
        end
      end

      defp parse_input(date, parser) do
        case load_input(date) |> parser.input() do
          {:ok, result, _, _, _, _} -> {:ok, input: result}
          {:ok, result} -> result
        end
      end

      defp load_input_lines(date) do
        load_input(date) |> Advent.input_lines()
      end

      defp load_input_lines_to_integer(date) do
        load_input(date) |> Advent.input_lines_to_integer()
      end

      defp load_input_chunks(date, chunk_by \\ "\n\n") do
        load_input(date) |> Advent.input_chunks(chunk_by)
      end

      defp load_input_lines_chunked(date, chunk_by \\ "\n\n") do
        load_input(date) |> Advent.input_lines_chunked(chunk_by)
      end

      defp load_input_lines_chunked_to_integer(date, chunk_by \\ "\n\n") do
        load_input(date) |> Advent.input_lines_chunked_to_integer(chunk_by)
      end
    end
  end
end
