defmodule Discuss.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Router.Helpers

  # init function is used for any long running or expensive operations and it will only be executed one time for the life time of our application
  def init(_params) do
  end

  @doc """
    如果 assigns 裡有 user，就可以通過這個 plug，不然就是錯誤畫面。
  """
  # the function is called every single time that a request flows through this plug 
  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end
