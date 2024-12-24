defmodule Discuss.TopicController do
  use Discuss.Web, :controller

  # 這裡的 params 用來幫助我們解析 URL
  def new(conn, params) do
    IO.puts "++++"  # 輸出一些簡單的字串用 puts
    IO.inspect conn # 輸出一些深度嵌套資料結構用 inspect。inspect 會爬遍所有的資料結構，試著印出所有的值。
    IO.puts "++++"  
    IO.inspect params
    IO.puts "++++"  
  end
end
