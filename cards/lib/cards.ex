defmodule Cards do
  @moduledoc """
  Documentation for `Cards`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Cards.hello()
      :world

  """
  def create_deck do
    values = ["Ace", "Two", "Three"]
    suits = ["Spades", "Clubs", "Hearts", "Diamond"]

    for value <- values, suit <- suits do
      "#{value} of #{suit}"
    end
  end

  # 將 deck 隨機排列
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  # 確認 card 內的東西有沒有在 deck 裏
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  # 將 deck 裡的資料按 hand_size 給的數量瓜分出來
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  # 將 deck 裡的資料轉成二進制再轉成檔案
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
