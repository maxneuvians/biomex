defmodule Biomex.Model.Map do
  Application.ensure_all_started(:tzdata)

  defstruct width: 10, height: 10, elevation: %{}, moisture: %{},
  current_time: Timex.to_datetime({{2000, 1, 1}, {0, 0, 0}}),
  start_time: Timex.to_datetime({{2000, 1, 1}, {0, 0, 0}})
end
