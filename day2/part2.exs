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
    input = File.read!("input.txt") |> String.split("\n")
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
    do_check({string, check}, string, check, [])
  end

  defp do_check(o, <<string_char, string_rest::binary>>, <<check_char, check_rest::binary>>, dif) do
    if string_char == check_char do
      do_check(o, string_rest, check_rest, dif)
    else
      do_check(o, string_rest, check_rest, dif ++ [<<check_char>>, <<string_char>>])
    end
  end

  defp do_check({s, c} = original, _, <<>>, [a, b]) do
    IO.puts("#{inspect(original)} => #{a} + #{b}")
    [eq: pt1, del: ^b, ins: a, eq: pt2] = String.myers_difference(s, c)
    pt1 <> pt2
  end

  defp do_check(_, _, <<>>, _), do: nil
  defp do_check(_, <<>>, _, _), do: nil
end
