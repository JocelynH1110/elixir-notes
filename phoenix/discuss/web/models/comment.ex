defmodule Discuss.Comment do
  use Discuss.Web, :model

  @derive {Poison.Encoder, only: [:content]}  # 這個 model 裡只有 content 欄位會轉換到 json，其他欄位都不會

  schema "comments" do
    field :content, :string
    belongs_to :user, Discuss.User
    belongs_to :topic, Discuss.Topic

    timestamps()
  end

  def changeset(struct, pramas \\ %{}) do
    struct
    |> cast(pramas, [:content])
    |> validate_required([:content])
  end
end
