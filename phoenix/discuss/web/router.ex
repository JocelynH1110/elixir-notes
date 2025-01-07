defmodule Discuss.Router do
  use Discuss.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Discuss do
    pipe_through :browser # Use the default browser stack

    # 會自動導到需要的分頁
    resources "/", TopicController
  end

  scope "/auth", Discuss do
    pipe_through :browser # Use the default browser stack

    # :request 自動被 plug Ueberauth module 定義了，所以我們不用定義。
    # 將原本 "/github" 改寫成 "/:provider" ，這樣就不單單只可以接收一種 route
    # 這一個是處理剛進來初始的 OAuth 要求
    get "/:provider", AuthController, :request   

    # 這一個處理從 github 返回的
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", Discuss do
  #   pipe_through :api
  # end
end
