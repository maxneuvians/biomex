defmodule Biomex.Server.Tile do
  use GenServer

  def get({x,y}) do
     GenServer.whereis({:global, "tile-#{x},#{y}"})
  end

  def status(coords) do
    if pid = get(coords) do
      GenServer.call(pid, :status)
    end
  end

  def start_link({x,y}, elevation, moisture, _opts \\ []) do
    GenServer.start_link(__MODULE__, %Biomex.Model.Tile{
      elevation: elevation,
      moisture: moisture
    },
    name: {:global, "tile-#{x},#{y}"})
  end

  def init(tile) do
    {:ok, %{tile | biome: Biomex.Biomes.determin(tile.elevation, tile.moisture)}}
  end

  def handle_call(:status, _from, tile), do: {:reply, tile, tile}

  def handle_cast(:do_tick, tile) do
    {:noreply, tile}
  end

end
