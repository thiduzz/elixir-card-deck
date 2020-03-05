defmodule Cards do
  
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    values = ["Ace","Two","Three","Four", "Five"]
    suits = ["Spades","Hearts","Diamonds","Clubs"]
    for suit <- suits, value <- values do
      "#{value} of #{suit}" 
    end
  end

  def shuffle (deck) do
    Enum.shuffle(deck)    
  end

  @doc """
    Determines whether a deck has a specific card

  ## Examples

      iex> Cards.create_deck |> Cards.contains?("Ace of Spades")
      iex> true

  """
  def contains?(deck, hand) do
    Enum.member?(deck, hand)    
  end

  @doc """
    Divide the deck into a a hand the remainder of the deck.
    The `hand_size` argument indicates how many cards should be in the hand 

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, deck} = Cards.deal(deck,1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    #returns a tuple
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    
    case File.read(filename) do
      {:ok,binary} -> :erlang.binary_to_term(binary)
      {_, _reason} -> "File does not exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck 
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end

end
