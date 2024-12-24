defmodule Discuss.Topic do
  use Discuss.Web, :model

  # 已事先在 priv->repo 裡的 migrations 裡建立 topics table 進 postgres 裡了。
  schema "topics" do
    field :title, :string
  end
end
