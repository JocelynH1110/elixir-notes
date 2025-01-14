defmodule Discuss.User do
  use Discuss.Web, :model

  schema "users" do
    field :email, :string
    field :provider, :string
    field :token, :string
    has_many :topics, Discuss.Topic
    has_many :comments, Discuss.Comment

    timestamps()
  end

  @doc """
    changeset 函式是要驗證資料庫更新的資料
  """
  # struct 代表在資料庫裡的紀錄；params 代表我們想更新的資料
  # // 做了預設值引數在 elixir，如果傳送一個 nil 給 params，它將被預設為 empty map
  def changeset(struct, params \\ %{}) do 
    struct
    |> cast(params, [:email, :provider, :token]) # 在 params 裡只有後面 [] 內的東西會被留下。
    |> validate_required([:email, :provider, :token])
    end
end
