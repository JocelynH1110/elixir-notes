defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic # 將下面原本要寫成 Discuss.Topic 縮短成 Topic

  # 這裡的 params 用來幫助我們解析 URL
  def new(conn, params) do
    changeset = Topic.changeset(%Topic{}, %{})

    # show the new template
    render conn, "new.html"
  end
end
