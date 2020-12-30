defmodule DiscussWeb.PageController do
  use DiscussWeb, :controller

  def index(conn, _params) do
    IO.puts "=========="
    IO.inspect(conn.assigns)
    IO.puts "=========="
    render(conn, "index.html")
  end
end
