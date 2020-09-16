defmodule RealmServerWeb.PageController do
  use RealmServerWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
