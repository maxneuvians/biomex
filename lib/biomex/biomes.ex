defmodule Biomex.Biomes do

  def determin(elevation, _moisture) when elevation < 0.4, do: :water
  def determin(elevation, _moisture) when elevation < 0.41, do: :beach
  def determin(elevation, moisture) when elevation > 0.8 and moisture < 0.1, do: :scorched
  def determin(elevation, moisture) when elevation > 0.8 and moisture < 0.2, do: :bare
  def determin(elevation, moisture) when elevation > 0.8 and moisture < 0.5, do: :tundra
  def determin(elevation, _moisture) when elevation > 0.8, do: :snow
  def determin(elevation, moisture) when elevation > 0.6 and moisture < 0.33, do: :temperate_desert
  def determin(elevation, moisture) when elevation > 0.6 and moisture < 0.66, do: :shrubland
  def determin(elevation, _moisture) when elevation > 0.6, do: :taiga
  def determin(elevation, moisture) when elevation > 0.3 and moisture < 0.16, do: :temperate_desert
  def determin(elevation, moisture) when elevation > 0.3 and moisture < 0.50, do: :grassland
  def determin(elevation, moisture) when elevation > 0.3 and moisture < 0.83, do: :temperate_deciduos_forest
  def determin(elevation, _moisture) when elevation > 0.3, do: :temperate_rain_forest
  def determin(_elevation, moisture) when moisture < 0.16, do: :subtropical_desert
  def determin(_elevation, moisture) when moisture < 0.33, do: :grassland
  def determin(_elevation, moisture) when moisture < 0.66, do: :tropical_seasonal_forest
  def determin(_, _), do: :tropical_rain_forest

end
