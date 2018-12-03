ExUnit.start()

defmodule AOC.Day2.Part2 do
  use ExUnit.Case

  test "example" do
    input = [
      "abcde",
      "fghij",
      "klmno",
      "pqrst",
      "fguij",
      "axcye",
      "wvxyz"
    ]

    assert evaluate(input) == "fgij"
  end

  test "result" do
    input = File.read!("input.txt") |> String.trim() |> String.split("\n")
    assert evaluate(input) == "rmyxgdlihczskunpfijqcebtv"
  end

  def evaluate(input) do
    evaluate(input, input)
  end

  def evaluate(orig, [check | rest]) do
    IO.puts("checking #{check}")
    Enum.find_value(orig, &do_check(&1, check)) || evaluate(orig, rest)
  end

  def evaluate(orig, []), do: raise("no results")

  defp do_check(string, string), do: nil

  defp do_check(string, check) do
    IO.puts("checking #{string} with #{check}")

    case String.myers_difference(string, check) do
      [eq: pt1, del: <<_>>, ins: <<_>>, eq: pt2] -> pt1 <> pt2
      _ -> false
    end
  end
end
