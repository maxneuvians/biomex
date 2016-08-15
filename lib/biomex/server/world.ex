defmodule Biomex.Server.World do
  use GenServer
  import Supervisor.Spec, warn: false

  def age, do: GenServer.call(__MODULE__, :age)

  # Private API

  def start_link(map, _opts \\ []) do
    GenServer.start_link(__MODULE__, map, [name: __MODULE__])
  end

  def init(state) do

    Supervisor.start_link(
      [worker(Biomex.Server.Tile, [], restart: :transient)],
      [strategy: :simple_one_for_one, name: Biomex.Tile.Supervisor]
    )

    Map.keys(state.elevation)
    |> Enum.map(fn c ->
      Supervisor.start_child(Biomex.Tile.Supervisor,
        [c, state.elevation[c], state.moisture[c]]
      )
    end)

    send self, :tick
    {:ok, state}
  end

  def handle_call(:time, _from, state), do: {:reply, Timex.format!(state.current_time, "{ISO:Extended}"), state}

  def handle_cast(:do_tick, state) do
    Enum.each(Supervisor.which_children(Biomex.Tile.Supervisor), fn {_, pid, _, _} ->
      GenServer.cast(pid, :do_tick)
    end)
    {:noreply, state}
  end

  def handle_cast(:tick_time, %Biomex.Model.Map{current_time: nil} = state) do
    {:noreply, Map.put(state, :current_time, state.start_time)}
  end

  def handle_cast(:print_map, state) do
    Biomex.Printer.print(state)
    {:noreply, state}
  end

  def handle_cast(:tick_time, state) do
    {:noreply, Map.put(
      state, :current_time,
      Timex.add(
        state.current_time,
        Timex.Duration.from_hours(1)
      )
    )}
  end

  def handle_info(:tick, state) do
    GenServer.cast(__MODULE__, :tick_time)
    #GenServer.cast(__MODULE__, :do_tick)
    Process.send_after(self, :tick, 1_000)
    {:noreply, state}
  end

end
