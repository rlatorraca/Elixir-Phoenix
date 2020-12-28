defmodule DiscussWeb.AuthController do
  # diz ao phoenix que é um Controller
  use DiscussWeb, :controller
  plug Ueberauth

  def callback( %{assigns: %{ueberauth_auth: auth}} = conn, params) do




  end
end