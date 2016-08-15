defmodule Biomex.ColourMapper do

  def colour(elevation, _moisture) when elevation < 0.4 do
    [trunc(elevation * 102), trunc(elevation * 178), trunc(elevation * 255)]
  end

  def colour(elevation, _moisture) when elevation < 0.41 do
    [trunc(elevation * 233), trunc(elevation * 221), trunc(elevation * 199)]
  end

  def colour(elevation, moisture) when elevation > 0.8 and moisture < 0.1 do
    [trunc(elevation * 153), trunc(elevation * 153), trunc(elevation * 153)]
  end

  def colour(elevation, moisture) when elevation > 0.8 and moisture < 0.2 do
    [trunc(elevation * 187), trunc(elevation * 187), trunc(elevation * 187)]
  end

  def colour(elevation, moisture) when elevation > 0.8 and moisture < 0.5 do
    [trunc(elevation * 221), trunc(elevation * 221), trunc(elevation * 187)]
  end

  def colour(elevation, _moisture) when elevation > 0.8 do
    [trunc(elevation * 255), trunc(elevation * 255), trunc(elevation * 255)]
  end

  def colour(elevation, moisture) when elevation > 0.6 and moisture < 0.33 do
    [trunc(elevation * 228), trunc(elevation * 232), trunc(elevation * 202)]
  end

  def colour(elevation, moisture) when elevation > 0.6 and moisture < 0.66 do
    [trunc(elevation * 196), trunc(elevation * 204), trunc(elevation * 187)]
  end

  def colour(elevation, _moisture) when elevation > 0.6 do
    [trunc(elevation * 204), trunc(elevation * 212), trunc(elevation * 187)]
  end

  def colour(elevation, moisture) when elevation > 0.3 and moisture < 0.16 do
    [trunc(elevation * 228), trunc(elevation * 232), trunc(elevation * 202)]
  end

  def colour(elevation, moisture) when elevation > 0.3 and moisture < 0.50 do
    [trunc(elevation * 196), trunc(elevation * 212), trunc(elevation * 170)]
  end

  def colour(elevation, moisture) when elevation > 0.3 and moisture < 0.83 do
    [trunc(elevation * 180), trunc(elevation * 201), trunc(elevation * 169)]
  end

  def colour(elevation, _moisture) when elevation > 0.3 do
    [trunc(elevation * 164), trunc(elevation * 164), trunc(elevation * 168)]
  end

  def colour(_, _), do: [0, 0, 0]

end
