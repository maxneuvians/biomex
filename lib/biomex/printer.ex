defmodule Biomex.Printer do
  require Logger

  def print(map) do
    Logger.info "Printing map"
    {:ok, file} = File.open "test.png", [:write]
    rows = Enum.map(1..map.height, fn y ->
      Enum.map(1..map.width, fn x ->
        Biomex.ColourMapper.colour(map.elevation[{x,y}], map.moisture[{x,y}]) ++ [calculate_intensity(map.current_time.hour)]
      end)
    end)
    :png.create(%{size: {map.width, map.height}, mode: {:rgba, 8}, file: file})
    |> :png.append({:rows, rows})
    |> :png.close
    :ok = :file.close(file)
  end

  def print_grey(map) do
    Logger.info "Printing map"
    {:ok, file} = File.open "test_grey.png", [:write]
    rows = Enum.map(1..map.height, fn y ->
      Enum.map(1..map.width, fn x ->
        << trunc(map.elevation[{x,y}] * 255) >>
      end)
    end)
    :png.create(%{size: {map.width, map.height}, mode: {:grayscale, 8}, file: file})
    |> :png.append({:rows, rows})
    |> :png.close
    :ok = :file.close(file)
  end

  defp calculate_intensity(hour) when hour >= 5 and hour <= 19, do: 255 - (hour * 10)
  defp calculate_intensity(_), do: 255

end
