import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {token: window.userToken}})

socket.connect()

const createSocket = (topicId) => {
  // 會跑到 user_socket.ex 裡看有沒有 comments: 這個 channel
  let channel = socket.channel(`comments:${topicId}`, {})
  channel.join()
    .receive("ok", resp => { 
      renderComments(resp.comments);
    })
    .receive("error", resp => { console.log("Unable to join", resp) })

  // 取出 textarea 的值
  document.querySelector('button').addEventListener('click', () => {
    const content = document.querySelector('textarea').value;

    // 在 comments_channel 的 handle_in() 裡，會收到以下 push
    channel.push('comment:add', { content: content });
  });
}

function renderComments(comments){
  const renderedComments = comments.map(comment => {
    return `
      <li class="collection-item">
        ${comment.content}
      </li>
    `;
  });

  // 找在 show.html 設定好的元素，將處理好的 comments 列出。因為取得的是 array，要把它轉為 string，故用 join('')
  document.querySelector('.collection').innerHTML = renderedComments.join('');
}

window.createSocket = createSocket;
