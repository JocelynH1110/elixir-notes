defmodule Discuss.CommentsChannel do
  use Discuss.Web, :channel

  # name 是 socket.js 裡 let channel 的第一個參數，socker 代表 socket connection
  def join(name, _params, socket) do
    IO.puts("+++++")
    IO.puts(name)
    {:ok, %{hey: "there"}, socket}
  end

  def handle_in() do

  end
end
