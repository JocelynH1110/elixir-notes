defmodule Discuss.AuthController do
  # use 部份是告訴 phoenix 配置這個 module 當成 controller
  use Discuss.Web, :controller
  plug Ueberauth

  def callback(conn, params) do

  end
end
