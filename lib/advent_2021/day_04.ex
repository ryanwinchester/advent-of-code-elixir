defmodule Advent2021.Day04 do
  @moduledoc """
  --- Day 4: Giant Squid ---

  https://adventofcode.com/2021/day/4
  """

  @doc """
  To guarantee victory against the giant squid, figure out which board will win first.

  What will your final score be if you choose that board?

  ## Example

      iex> numbers = [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]
      iex> boards = [[
      ...>   [22, 13, 17, 11,  0],
      ...>   [ 8,  2, 23,  4, 24],
      ...>   [21,  9, 14, 16,  7],
      ...>   [ 6, 10,  3, 18,  5],
      ...>   [ 1, 12, 20, 15, 19],
      ...> ], [
      ...>   [ 3, 15,  0,  2, 22],
      ...>   [ 9, 18, 13, 17,  5],
      ...>   [19,  8,  7, 25, 23],
      ...>   [20, 11, 10, 24,  4],
      ...>   [14, 21, 16, 12,  6],
      ...> ], [
      ...>   [14, 21, 17, 24,  4],
      ...>   [10, 16, 15,  9, 19],
      ...>   [18,  8, 23, 26, 20],
      ...>   [22, 11, 13,  6,  5],
      ...>   [ 2,  0, 12,  3,  7],
      ...> ]]
      iex> Day04.part_1(numbers, boards)
      4512

  """
  def part_1(numbers, boards) do
    transposed_boards = Enum.map(boards, &transpose/1)

    {winning_sum, winning_num} =
      Enum.reduce_while(numbers, {boards ++ transposed_boards, nil}, fn number, {b, w} ->
        b = mark_numbers_on_boards(b, number)

        if winner = Enum.find(b, &has_row?/1) do
          {:halt, {sum_board(winner), number}}
        else
          {:cont, {b, w}}
        end
      end)

    winning_sum * winning_num
  end

  @doc """
  Figure out which board will win last. Once it wins, what would its final score be?

  ## Example

      iex> numbers = [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1]
      iex> boards = [[
      ...>   [22, 13, 17, 11,  0],
      ...>   [ 8,  2, 23,  4, 24],
      ...>   [21,  9, 14, 16,  7],
      ...>   [ 6, 10,  3, 18,  5],
      ...>   [ 1, 12, 20, 15, 19],
      ...> ], [
      ...>   [ 3, 15,  0,  2, 22],
      ...>   [ 9, 18, 13, 17,  5],
      ...>   [19,  8,  7, 25, 23],
      ...>   [20, 11, 10, 24,  4],
      ...>   [14, 21, 16, 12,  6],
      ...> ], [
      ...>   [14, 21, 17, 24,  4],
      ...>   [10, 16, 15,  9, 19],
      ...>   [18,  8, 23, 26, 20],
      ...>   [22, 11, 13,  6,  5],
      ...>   [ 2,  0, 12,  3,  7],
      ...> ]]
      iex> Day04.part_2(numbers, boards)
      1924

  """
  def part_2(numbers, boards) do
    {losing_sum, losing_num} =
      Enum.reduce_while(numbers, {boards, nil}, fn number, {b_acc, _} ->
        marked_boards = mark_numbers_on_boards(b_acc, number)

        case reject_winners(marked_boards) do
          [] ->
            {:halt, {Enum.at(marked_boards, 0) |> sum_board(), number}}

          boards_left ->
            {:cont, {boards_left, number}}
        end
      end)

    losing_sum * losing_num
  end

  ## Helpers

  defp mark_numbers_on_boards(boards, number) do
    Enum.map(boards, fn board ->
      Enum.map(board, fn row ->
        Enum.map(row, &if(&1 == number, do: -1, else: &1))
      end)
    end)
  end

  defp has_row?(board) do
    Enum.any?(board, &(Enum.sum(&1) == -5))
  end

  defp is_winner?(board) do
    Enum.any?(board, &(Enum.sum(&1) == -5)) or Enum.any?(transpose(board), &(Enum.sum(&1) == -5))
  end

  defp sum_board(board) do
    Enum.reduce(board, 0, fn row, sum ->
      Enum.reduce(row, sum, &if(&1 >= 0, do: &1 + &2, else: &2))
    end)
  end

  defp reject_winners(boards) do
    Enum.reject(boards, &is_winner?/1)
  end

  # Transpose the list.
  defp transpose(rows), do: List.zip(rows) |> Enum.map(&Tuple.to_list/1)
end
