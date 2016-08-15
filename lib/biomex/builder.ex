defmodule Biomex.Builder do
  require Logger

  def build do
    map = %Biomex.Model.Map{}

    elevation_task = Task.async(fn -> map |> build_elevation end)
    moisture_task = Task.async(fn -> map |> build_moisture end)

    Map.put(map, :elevation, Task.await(elevation_task,  60_000))
    |> Map.put(:moisture, Task.await(moisture_task, 60_000))
  end


  def build_elevation(map) do
    Logger.info "Reticulating Splines"
    config = Noise.Simplex.new_config(%{minimum: 0, maximum: 1, frequency: 0.007, octaves: 5})
    for(x <- 1..map.width, y <- 1..map.height, do: {x,y})
    |> Enum.reduce(%{}, fn c, acc ->
      Map.put_new(acc,c, (calculate_noise(c, config)))
    end)
  end

  def build_moisture(map) do
    Logger.info "Adding Wetness"
    config = Noise.Simplex.new_config(%{minimum: 0, maximum: 1, frequency: 0.01, octaves: 2})
    for(x <- 1..map.width, y <- 1..map.height, do: {x,y})
    |> Enum.reduce(%{}, fn c, acc ->
      Map.put_new(acc,c, (calculate_noise(c, config)))
    end)
  end

  defp calculate_noise(c, config) do
    Noise.Simplex.get(config, c)
  end

end
