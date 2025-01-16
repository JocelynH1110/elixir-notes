import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicId) => {
  // 會跑到 user_socket.ex 裡看有沒有 comments: 這個 channel
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })

  // 取出 textarea 的值
  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;

    // 在 comments_channel 的 handle_in() 裡，會收到以下 push
    channel.push('comment:add', { content: content });
  });
}

window.createSocket = createSocket;
