ExUnit.start()

defmodule AOC.Day1.Part2 do
  use ExUnit.Case

  test "ex1", do: assert(0 = loop(0, [+1, -1]))
  test "ex2", do: assert(10 = loop(0, [+3, +3, +4, -2, -4]))
  test "ex3", do: assert(5 = loop(0, [-6, +3, +8, +5, -6]))
  test "ex4", do: assert(14 = loop(0, [+7, +7, -2, -7, -4]))
  test "ex5", do: assert(2 == loop(0, [+1, -2, +3, +1]))

  def loop(current, sequence, acc \\ []) when is_integer(current) when is_list(sequence) do
    IO.puts("Starting check: #{current} accumulator: #{inspect(acc)}")

    if 0 in acc do
      current
    else
      case Enum.reduce(sequence, {current, acc}, &do_loop/2) do
        {new_current, new_acc} -> loop(new_current, sequence, new_acc)
        result -> result
      end
    end
  end

  defp do_loop(change, {current, acc}) do
    result = change + current

    IO.puts(
      "\tCurrent frequency: #{current}, change of: #{change}; resulting frequency: #{result}"
    )

    if result in acc, do: result, else: {result, acc ++ [result]}
  end

  defp do_loop(_, result), do: result

  def run(start), do: loop(start, get_sequence("part1_input.txt"), [])

  defp get_sequence(input) when is_binary(input) do
    File.stream!(input, [modes: [:raw, :read_ahead, :binary]], :line)
    |> Enum.map(&decode/1)
  end

  defp decode(data) do
    {num, "\n"} = Integer.parse(data)
    num
  end
end

IO.inspect(AOC.Day1.Part2.run(0), label: "RESULT")
