ExUnit.start()

defmodule AOC.Day2.Part1 do
  use ExUnit.Case

  test "abcdef" do
    # abcdef contains no letters that appear exactly two or three times.
    refute twice("abcdef")
    refute thrice("abcdef")
  end

  test "bababc" do
    # bababc contains two a and three b, so it counts for both.
    assert twice("bababc")
    assert thrice("bababc")
  end

  test "abbcde" do
    # abbcde contains two b, but no letter appears exactly three times.
    assert twice("abbcde")
    refute thrice("abbcde")
  end

  test "abcccd" do
    # abcccd contains three c, but no letter appears exactly two times.
    refute twice("abcccd")
    assert thrice("abcccd")
  end

  test "aabcdd" do
    # aabcdd contains two a and two d, but it only counts once.
    assert twice("aabcdd")
    refute thrice("aabcdd")
  end

  test "abcdee" do
    # abcdee contains two e.
    assert twice("abcdee")
    refute thrice("abcdee")
  end

  test "ababab" do
    # ababab contains three a and three b, but it only counts once.
    assert thrice("ababab")
    refute twice("ababab")
  end

  test "result" do
    {twos, threes} =
      File.stream!("./input.txt", [modes: [:raw, :read_ahead, :binary]], :line)
      |> Stream.map(&String.trim(&1, "\n"))
      |> Enum.reduce({0, 0}, fn id, {two, three} ->
        two = if twice(id), do: two + 1, else: two
        three = if thrice(id), do: three + 1, else: three
        {two, three}
      end)

    IO.inspect(twos * threes, label: "RESULT")
  end

  def twice(orig), do: twice(orig, orig)
  def twice(_orig, <<>>), do: false

  def twice(orig, <<char, rest::binary>>) do
    case String.split(orig, <<char>>) do
      [_, _, _] ->
        true

      r ->
        IO.puts("#{<<char>>} does not appear twice: #{inspect(r)}")
        twice(orig, rest)
    end
  end

  def thrice(orig), do: thrice(orig, orig)
  def thrice(_orig, <<>>), do: false

  def thrice(orig, <<char, rest::binary>>) do
    case String.split(orig, <<char>>) do
      [_, _, _, _] ->
        true

      r ->
        IO.puts("#{<<char>>} does not appear thrice: #{inspect(r)}")
        thrice(orig, rest)
    end
  end
end
