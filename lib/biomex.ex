defmodule Biomex do
  use Application

  def attach(map) do
    Supervisor.start_child(Biomex.World.Supervisor, [map])
  end

  def new do
    Biomex.Builder.build
  end

  def start(_type, _args) do
    Biomex.World.Supervisor.start_link
  end

end
