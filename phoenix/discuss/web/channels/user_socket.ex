defmodule Discuss.UserSocket do
  use Phoenix.Socket

  channel "comments:*", Discuss.CommentsChannel #:* 是 wild card，就是可帶入資料的。此行告訴 Phoenix 有一個叫 comments 的 channel。

  transport :websocket, Phoenix.Transports.WebSocket

  # 此函式是無論何時一個新的 JavaScript client 連線到 Phoenix server with websocket
  # 這裡的 socket 類似 controller 的 conn
  def connect(_params, socket) do
    {:ok, socket}
  end

  def id(_socket), do: nil
end
