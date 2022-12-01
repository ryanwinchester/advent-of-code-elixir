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
        "../support/inputs/#{year}/#{file}.txt"
        |> Path.expand(__DIR__)
        |> File.read!()
        |> String.split("\n", trim: true)
      end

      defp load_file_groups(year, file) do
        "../support/inputs/#{year}/#{file}.txt"
        |> Path.expand(__DIR__)
        |> File.read!()
        |> String.split("\n\n", trim: true)
        |> Enum.map(&String.split(&1, "\n", trim: true))
      end
    end
  end
end
