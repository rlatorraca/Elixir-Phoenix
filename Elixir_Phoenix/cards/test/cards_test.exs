defmodule CardsTest do
  use ExUnit.Case

  # Using DOC Test
  # Get the EXAAMPLES we created using EX_DOC
  doctest Cards # Call doctests

  # Using ASSERT
  test "greets the world" do
    assert 1 + 1 == 2
  end

  test "create_deck makes 52 cards - Full deck" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 52
  end

  test "shuffle a deck radomizes it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end

  test "shuffle a deck radomizes it - 2" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end

end
