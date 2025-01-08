defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  @doc """
    changeset 函式是要驗證資料庫更新的資料
  """
  # struct 代表在資料庫裡的紀錄；params 代表我們想更新的資料
  # // 做了預設值引數在 elixir，如果傳送一個 nil 給 params，它將被預設為 empty map
  def changeset(struct, params \\ %{}) do 
    struct
    |> cast(params, [:email, :provider, :token]) # 產生一個 changeset，裡面描述如何將原有的 struct，更新成 pramas
    |> validate_required([:email, :provider, :token])
    end
end
