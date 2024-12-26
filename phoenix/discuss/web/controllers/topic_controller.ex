defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topic # 將下面原本要寫成 Discuss.Topic 縮短成 Topic

  # 這裡的 params 用來幫助我們解析 URL
  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    # show the new template
    # 將自定的變數 changeset 傳到 template
    render conn, "new.html", changeset: changeset
  end

  # 將表格裡的資料傳到第二個引數
  # 第二引數值是由 params = %{"topic" = "使用者輸入的資料"}，轉化而來，因為 params.topic 無法直接找到值，因為 key 是字串，所以改成 %{"topic" => topic} = params 用 topic 來接收 "使用者輸入的資料"。
  def create(conn, %{"topic" => topic}) do
     changeset = Topic.changeset(%Topic{}, topic)

    # 將新增的資料插入資料庫
    # insert 會自動探測 changeset 是否有符合
    case Repo.insert(changeset) do
    {:ok, post} ->IO.inspect(post) 
    {:error, changeset} ->IO.inspect(changeset)
    end
  end
end
