defmodule DiscussWeb.CommentsChannel do
  use DiscussWeb, :channel

  def join(comments, _message, socket) do
    IO.puts("-------------------------------------")
    IO.puts(comments)
    {:ok, %{hey: "Rodrigo Pires" }, socket}
  end

  def handle_in() do

  end
enad