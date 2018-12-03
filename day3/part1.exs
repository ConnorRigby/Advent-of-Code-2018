ExUnit.start()

defmodule AOC.Day2.Part1 do
  use ExUnit.Case

  defstruct [:id, :x, :y, :w, :h]

  @moduletag tag: [timeout: :infinity]
  test "example" do
    input =
      """
      #1 @ 1,3: 4x4
      #2 @ 3,1: 4x4
      #3 @ 5,5: 2x2
      """
      # input = """
      # #3 @ 5,5: 2x2
      # """
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&decode/1)

    assert evaluate(input) == 4
  end

  @tag timeout: :infinity
  test "results" do
    input =
      File.read!("input.txt")
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&decode/1)

    IO.inspect(evaluate(input), label: "RESULTS")
  end

  def evaluate(list) do
    xmax =
      Enum.reduce(list, 0, fn %{x: x, w: w}, xmax ->
        (x + w > xmax && x + w) || xmax
      end)

    ymax =
      Enum.reduce(list, 0, fn %{y: y, h: h}, ymax ->
        (y + h > ymax && y + h) || ymax
      end)

    map = Enum.map(0..ymax, fn _ypos -> Enum.map(0..xmax, fn _xpos -> "." end) end)

    Enum.reduce(0..ymax, map, fn ypos, map ->
      List.update_at(map, ypos, fn row ->
        Enum.reduce(0..xmax, row, fn xpos, row ->
          List.update_at(row, xpos, fn itm ->
            should_mark =
              Enum.filter(list, fn %{x: x, y: y, w: w, h: h} ->
                xpos >= x && xpos < x + w && (ypos >= y && ypos < y + h)
              end)

            case should_mark do
              [] -> itm
              [%{id: id}] -> to_string(id)
              _ -> "X"
            end
          end)
        end)
      end)
    end)
    |> List.flatten()
    |> Enum.filter(&match?("X", &1))
    |> Enum.count()
  end

  def decode("#" <> string) do
    [idstr, "@", xy, wh] = String.split(string, " ")
    {id, ""} = Integer.parse(idstr)
    [xstr, ystr] = String.trim(xy, ":") |> String.split(",")
    {x, ""} = Integer.parse(xstr)
    {y, ""} = Integer.parse(ystr)
    [wstr, hstr] = String.split(wh, "x")
    {w, ""} = Integer.parse(wstr)
    {h, ""} = Integer.parse(hstr)
    %__MODULE__{id: id, x: x, y: y, w: w, h: h}
  end
end
