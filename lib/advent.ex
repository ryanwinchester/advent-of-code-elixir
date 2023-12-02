defmodule Advent do
  @moduledoc """
  Advent of Code functions for Elixir.
  """

  @doc """
  Take the input and split into lines.

  ## Example

      iex> input = \"""
      ...> a
      ...> b
      ...> c
      ...> \"""
      iex> input_lines(input)
      ["a", "b", "c"]

  """
  @spec input_lines(String.t()) :: [String.t()]
  def input_lines(input) do
    :binary.split(input, "\n", [:global])
  end

  @doc """
  Take the input and split into integers.

  ## Example

      iex> input = \"""
      ...> 1
      ...> 2
      ...> 3
      ...> \"""
      iex> input_lines_to_integer(input)
      [1, 2, 3]

  """
  @spec input_lines_to_integer(String.t()) :: [integer()]
  def input_lines_to_integer(input) do
    input_lines(input) |> Enum.map(&String.to_integer/1)
  end

  @doc """
  Take the input and split into chunked strings.

  ## Example

      iex> input = \"""
      ...> a
      ...> b
      ...>
      ...> c
      ...> \"""
      iex> input_chunks(input)
      ["a\\nb", "c\\n"]

  """
  @spec input_chunks(String.t(), String.t()) :: [String.t()]
  def input_chunks(input, chunk_by \\ "\n\n") do
    String.split(input, chunk_by, trim: true)
  end

  @doc """
  Take the input and split into chunks of lines.

  ## Example

      iex> input = \"""
      ...> a
      ...> b
      ...>
      ...> c
      ...> \"""
      iex> input_lines_chunked(input)
      [["a", "b"], ["c"]]

  """
  @spec input_lines_chunked(String.t(), String.t()) :: [[String.t()]]
  def input_lines_chunked(input, chunk_by \\ "\n\n") do
    input_chunks(input, chunk_by) |> Enum.map(&String.split(&1, "\n", trim: true))
  end

  @doc """
  Take the input and split into chunks of integers.

   ## Example

      iex> input = \"""
      ...> 1
      ...> 2
      ...>
      ...> 3
      ...> \"""
      iex> input_lines_chunked_to_integer(input)
      [[1, 2], [3]]

  """
  @spec input_lines_chunked_to_integer(String.t(), String.t()) :: [[integer()]]
  def input_lines_chunked_to_integer(input, chunk_by \\ "\n\n") do
    groups = input_lines_chunked(input, chunk_by)

    for g <- groups do
      for n <- g do
        String.to_integer(n)
      end
    end
  end
end
