defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic # 將下面原本要寫成 Discuss.Topic 縮短成 Topic


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
     changeset = Topic.changeset(%Topic{}, topic)

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
end
