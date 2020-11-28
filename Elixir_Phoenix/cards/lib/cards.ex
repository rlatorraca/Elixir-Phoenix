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
  def hello do
    :world
  end


  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
    suits = ["Spade", "Club", "Heart", "Diamond"]

    # WRONG WAY
    # cards = for value <- values do
    #          for suit <- suits do
    #            "#{value} of #{suit}"
    #          end
    #        end
    # List.flatten(cards)

    # CORRECT WAY
    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    file = :erlang.term_to_binary(deck)
    File.write(filename, file)
  end
end