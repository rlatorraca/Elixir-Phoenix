defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  def join(comments, _payload, socket) do
    IO.puts(comments)
    {:ok, %{hey: "Rodrigo Pires" }, socket}
  end

  def handle_in(comments, payload, socket) do

    {:reply, {:ok, payload}, socket}
  end
end