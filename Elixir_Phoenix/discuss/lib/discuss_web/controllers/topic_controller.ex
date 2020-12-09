defmodule Discuss.TopicController do
  use DiscussWeb, :controller

  def new(conn, _params) do
    render(conn, "index.html")
  end
end