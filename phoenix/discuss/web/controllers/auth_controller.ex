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

    insert_or_update_user(changeset)
  end

  @doc """
      檢查是否有任何使用者的信箱已在 table 裡。若已存在，將更新使用者的新 token; 若不存在，將加進資料庫。
  """
  # defp 為 private function 其他 module 無法呼叫它，只在 AuthController 下使用
  defp insert_or_update_user(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end
end 

