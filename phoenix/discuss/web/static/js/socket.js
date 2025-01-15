import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

// 會跑到 user_socket.ex 裡看有沒有 comments:1 這個 channel
let channel = socket.channel("comments:1", {})

channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })

// 當有人點擊 button，就會執行後面的 function()
document.querySelector('button').addEventListener('click', function(){
  channel.push('comment:Hello', { hi: 'there!!' })
});
export default socket
