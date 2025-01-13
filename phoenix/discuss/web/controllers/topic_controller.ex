defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic # 將下面原本要寫成 Discuss.Topic 縮短成 Topic

  plug Discuss.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]

  # 這個 plug 會看 TopicController 是否有個函式叫做 :check_topic_owner，若有的話，此 plug 會在後面未包含的函式前先行執行。 
  plug  :check_topic_owner when not action in [:index, :new, :create]

  @doc """
    取得所有資料庫儲存的資料，並套用 template
  """
  def index(conn, _params) do
    IO.inspect(conn.assigns)
    topics = Repo.all(Topic)  # 等於 topics = Discuss.Repo.all(Discuss.Topic)

    render conn, "index.html", topics: topics
  end

  @doc """
     用來顯示要新增資料時要填的空白表格。
     這裡的 params 用來幫助我們解析 URL
  """
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    # render with a connection and specify the template "new.html"
    # 將自定的變數 changeset 傳到 template
    render conn, "new.html", changeset: changeset
  end

  # 將新增到表格裡的資料傳到第二個引數
  # 第二引數值是由 params = %{"topic" = "使用者輸入的資料"}，轉化而來，因為 params.topic 無法直接找到值，因為 key 是字串，所以改成 %{"topic" => topic} = params 用 topic 來接收 "使用者輸入的資料"。
  def create(conn, %{"topic" => topic}) do
    # 取得使用者，將使用者傳遞到第一個參數（影藏的）建立連接關係。並會建立一個 topics struct 然後傳遞到 changeset 的第一個argument
    changeset = conn.assigns.user
      |> build_assoc(:topics)   # models.user 裡的 schema 定義了 :topics 這個名字
      |> Topic.changeset(topic)

    # 將新增的資料插入資料庫
    # insert 會自動探測 changeset 是否有符合
    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:error, "Created Failed")
        |> redirect(to: topic_path(conn, :new))
        render conn, "new.html", changeset: changeset
    end
  end

  def edit(conn, %{"id" => topic_id}) do
    topic = Repo.get(Topic, topic_id) # 從資料庫取出 Topic 中的 topic_id
    changeset = Topic.changeset(topic)  # 第二個值給空值，表示尚未改變資料(因為是編輯畫面)，為一個空的 map

    render conn, "edit.html", changeset: changeset, topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do

    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)
    # changeset 指要將更新已存在資料庫資料送到新的 form 裡
    # 在 get 裡取得的舊資料(struct）傳送到 changeset 的第一個參數，topic 是第二個參數，指的是更新後的資料。
    # changeset = Repo.get(Topic, topic_id) |> Topic.changeset(topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :index))
      {:error, changeset} ->
        render conn, "edit.html", changeset: changeset, topic: old_topic 
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  @doc """
  確認當前使用者是否為文章的擁有者，若不是就轉址到其他路由。即便改路由到其他擁有者的文章，也會傳回 error。
  """
  def check_topic_owner(conn, _params) do   # 這裡的 params 不是 router、form 跟其他 function 不同 
    # router 裡的 resource helper 裡的會自動拉 id 下來，所以這裡的 params 才會有值。
    %{params: %{"id" => topic_id}} = conn 

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: topic_path(conn, :index))
      |> halt() # 指停止這個 plug
    end
  end
end
