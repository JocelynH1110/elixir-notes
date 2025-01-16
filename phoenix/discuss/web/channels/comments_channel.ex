defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  alias Discuss.Topic

  @doc """
    當使用者進入 channel，會寄送所有與目前 topic 有關的 comments。
  """
  # 第一個參數是 socket.js 裡 let channel 的第一個參數，socker 代表 socket connection
  # <> 是如何把 string 在 elixir 加在一起。無論 comments: 後接了什麼字，都會自動被安排進變數 topic_id 裡。
  def join("comments:" <> topic_id, _params, socket) do
    topic_id = String.to_integer(topic_id)  # 因為取得的是字串要改成 psql、ecto 認為的 int
    topic = Repo.get(Topic, topic_id) # 從 Topic models 裡拿出 topic_id

    {:ok, %{}, socket}
  end

  @doc """
    當使用者加入新的 comment，或點擊 submit， 將會發射一個事件或發布一個事件給會收到 handle_in() 的伺服器。會儲存 comment
  """
  def handle_in(name, %{"content" => content}, socket) do
    {:reply, :ok, socket}   # 這是告訴 phoenix 目前狀況，讓它回覆給 user
  end
end
