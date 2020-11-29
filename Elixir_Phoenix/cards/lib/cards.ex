defmodule Cards do
  @moduledoc """
    Provide methods for creating and handling a poker deck of cards.
  """

  @doc"""
    Returns a list of strings representing a deck of pocker cards.
  """
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

  @doc"""
    Determines whether a deck contains a given card

  ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Jack of Club")
        true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc"""
    Split a deck into a hand and the remainder of the deck.
    The  `hand_size` argument indicates hwo many cards should be in the hand.
  ## Examples

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck,5)
        iex> hand
        ["Ace of Spade", "Two of Spade", "Three of Spade", "Four of Spade", "Five of Spade"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    file = :erlang.term_to_binary(deck)
    File.write(filename, file)
  end

  def load(filename) do

    # Expanded Version - Pattern Matching
    # {status, file} = File.read(filename)
    #case status do
    #  :ok -> :erlang.binary_to_term file
    #  :error -> "That file does not exist"
    #end

    case File.read(filename) do
      {:ok, file} -> :erlang.binary_to_term file
      {:error, _reason} -> "That file does not exist"
    end

  end

  def create_hand(hand_size) do

    # Expanded Version (no pipeline)
    # deck = Cards.create_deck()
    # deck = Cards.shuffle(deck)
    # hand = Cards.deal(deck, hand_size)

    # Using Pipeline
    Cards.create_deck
      |> Cards.shuffle
      |> Cards.deal(hand_size)
  end

end