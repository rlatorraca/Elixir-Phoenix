defmodule DiscussWeb.TopicController do
  use DiscussWeb, :controller

  alias DiscussWeb.Topic

  def new(conn, _params) do
    #struct = %Topic{}
    #params = %{}
    #changeset = Topic.changeset(struct, params)
    changeset = Topic.changeset(%Topic{}, %{})
    render(conn,"new.html", changeset: changeset)
  end

"""
  def create(conn, params) do
    #IO.inspect(params)
    %{"topic" => topic} = params
  end
"""

  def create(conn, %{"topic" => topic}) do
    # ex: "topic" => %{"title" => "Rodrigo"}

  end
end