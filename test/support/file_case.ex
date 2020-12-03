defmodule Advent.FileCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      defp load_file(file) do
      "../support/inputs/#{file}.txt"
      |> Path.expand(__DIR__)
      |> File.read!()
      |> String.split("\n", trim: true)
      end
    end
  end
end
