# 這 Plugs 主要是抓出 session 裡的使用者 id ，並從資料庫取出使用者，然後做些連線小轉變和連線上設定使用者 model

defmodule Discuss.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias Discuss.Repo
  alias Discuss.User

  def init(_params) do
  end

  # 這裡的 params 是來自 init()
  def call(conn, _params) do
    user_id = get_session(conn, :user_id) # session 資料來自 import ...Controller

    cond do
      # 以下碼做兩件事，1.將取得 id 傳入變數。2.通過 condition statement
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user) # 資料來自 import Plug.Conn
      true ->
        assign(conn, :user, nil)
    end
  end
end
