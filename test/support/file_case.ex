defmodule Advent.FileCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp load_file(year, file) do
        "../support/inputs/#{year}/#{file}.txt"
        |> Path.expand(__DIR__)
        |> File.read!()
      end

      defp load_file_lines(year, file) do
        load_file(year, file) |> String.split("\n", trim: true)
      end

      defp load_file_lines_to_integer(year, file) do
        load_file_lines(year, file) |> Enum.map(&String.to_integer/1)
      end

      defp load_file_chunks(year, file, chunk_by \\ "\n\n") do
        load_file(year, file) |> String.split(chunk_by, trim: true)
      end

      defp load_file_lines_chunked(year, file, chunk_by \\ "\n\n") do
        load_file_chunks(year, file) |> Enum.map(&String.split(&1, "\n", trim: true))
      end

      defp load_file_lines_chunked_to_integer(year, file, chunk_by \\ "\n\n") do
        groups = load_file_lines_chunked(year, file, chunk_by)

        for g <- groups do
          for n <- g do
            String.to_integer(n)
          end
        end
      end
    end
  end
end
