defmodule Advent.FileCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp load_input(year, file) do
        "../support/inputs/#{year}/#{file}.txt"
        |> Path.expand(__DIR__)
        |> File.read!()
      end

      defp load_input_lines(year, file) do
        load_input(year, file) |> Advent.input_lines()
      end

      defp load_input_lines_to_integer(year, file) do
        load_input(year, file) |> Advent.input_lines_to_integer()
      end

      defp load_input_chunks(year, file, chunk_by \\ "\n\n") do
        load_input(year, file) |> Advent.input_chunks(chunk_by)
      end

      defp load_input_lines_chunked(year, file, chunk_by \\ "\n\n") do
        load_input(year, file) |> Advent.input_lines_chunked(chunk_by)
      end

      defp load_input_lines_chunked_to_integer(year, file, chunk_by \\ "\n\n") do
        load_input(year, file) |> Advent.input_lines_chunked_to_integer(chunk_by)
      end
    end
  end
end
