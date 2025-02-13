defmodule Discuss.Topic do
  use Discuss.Web, :model

  # 已事先在 priv->repo 裡的 migrations 裡建立 topics table 進 postgres 裡了。
  # 以下是說，在 postgres 裡找一個 table 叫 topics，那個 table 有欄位叫 title 其每個值都會放入 string
  schema "topics" do
    field :title, :string
    belongs_to :user, Discuss.User
    has_many :comments, Discuss.Comment
  end

  @doc """
    changeset 函式是要驗證資料庫更新的資料
  """
  # struct 代表在資料庫裡的紀錄；params 代表我們想更新的資料
  # // 做了預設值引數在 elixir，如果傳送一個 nil 給 params，它將被預設為 empty map
  def changeset(struct, params \\ %{}) do 
    struct
    |> cast(params, [:title]) # 產生一個 changeset，裡面描述如何將原有的 struct，更新成 pramas
    |> validate_required([:title])
    end
end
