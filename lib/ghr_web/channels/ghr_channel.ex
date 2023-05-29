defmodule GhrWeb.GhrChannel do
  use GhrWeb, :channel
  use ChannelHandler.Router

  alias GhrWeb.Presence
  alias Ghr.Data.ImportPayroll, as: Payroll

  # plug GhrWeb.ChannelPlugs.EnsureAuthenticated

  event "payroll:get_month", GhrWeb.PayrollHandler, :get_month

  @impl true
  def join("ghr:lobby", payload, socket) do
    if authorized?(payload) do
      send(self(), :after_join)
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  @impl true
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic (ghr:lobby).
  @impl true
  def handle_in("shout", payload, socket) do
    broadcast(socket, "shout", payload)
    {:noreply, socket}
  end

  @impl true
  def handle_info(:after_join, socket) do
    presence = Presence.get_by_key(socket, socket.assigns.name)
    IO.inspect presence, label: "Presence Data:"

    {:ok, _} =
      Presence.track(socket, socket.assigns.name, %{
        online_at: inspect(System.system_time(:second))
      })

    push(socket, "presence_state", Presence.list(socket))
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
