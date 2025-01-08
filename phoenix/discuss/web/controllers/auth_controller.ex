defmodule Discuss.AuthController do
  # use 部份是告訴 phoenix 配置這個 module 當成 controller
  use Discuss.Web, :controller
  plug Ueberauth

  alias Discuss.User

  def callback(%{assigns: %{ueberauth_auth: auth}} = conn, params) do

    # 取出想插入資料庫的資料
    user_params = %{token: auth.credentials.token, email: auth.info.email, provider: "github" }

    # 設定一個空 struct，將資料 user_params 插入資料庫
    changeset = User.changeset(%User{}, user_params)
  end
end
