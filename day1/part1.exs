defmodule AOC.Day1.Part1 do
  def run(input) do
    File.stream!(input, [modes: [:raw, :read_ahead, :binary]], :line)
    |> Stream.map(&decode/1)
    |> Enum.reduce(0, &reduce/2)
  end

  def decode(data) do
    {num, "\n"} = Integer.parse(data)
    num
  end

  def reduce(num, acc), do: num + acc
end

IO.inspect(AOC.Day1.Part1.run("part1_input.txt"), label: "RESULT")
