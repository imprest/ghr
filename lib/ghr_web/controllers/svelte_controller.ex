defmodule GhrWeb.SvelteController do
  use GhrWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
