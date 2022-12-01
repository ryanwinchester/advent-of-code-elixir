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

      defp load_file_lines_grouped(year, file, chunk_by \\ "\n\n") do
        load_file(year, file)
        |> String.split(chunk_by, trim: true)
        |> Enum.map(&String.split(&1, "\n", trim: true))
      end
    end
  end
end
