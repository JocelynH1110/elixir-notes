defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  @doc """
    當使用者進入 channel，會寄送所有與目前 topic 有關的 comments。
  """
  # name 是 socket.js 裡 let channel 的第一個參數，socker 代表 socket connection
  def join(name, _params, socket) do
    {:ok, %{hey: "there"}, socket}
  end

  @doc """
    當使用者加入新的 comment，或點擊 submit， 將會發射一個事件或發布一個事件給會收到 handle_in() 的伺服器。會儲存 comment
  """
  def handle_in(name, message, socket) do
    IO.puts("+++++")
    IO.puts(name)
    IO.inspect(message)

    {:reply, :ok, socket}   # 這是告訴 phoenix 目前狀況，讓它回覆給 user
  end
end
