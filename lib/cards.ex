defmodule Cards do
    @moduledoc """
    Provides methods for creating and handling a deck of cards
    """

    @doc """
    Represents a list of strings representing a deck of playing cards
    """

    def create_deck do
        values = ["Ace", "Two", "Three", "Four", "Five"]
        suits = ["Spades", "Hearts", "Diamonds", "Clubs"]

        for value <- values, suit <- suits do   
            "#{value} of #{suit}"
        end
        end
    @doc """
    Shuffles an array of playing cards.
    """

    def shuffle(deck) do
        Enum.shuffle(deck)       
    end

    @doc """
    This method takes deck and a single card as parameters, and figures if the
    deck contains the given card.

    ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true
        iex> Cards.contains?(deck, "Six of Hearts")
        false
        
    """

    def contains?(deck,card) do
        Enum.member?(deck,card)
    end

    @doc """
    Divides a deck into a hand and the remainder of the deck. 
    The `hand_size` argument indicates how many cards should 
    be in the hand.

    ## Examples
        iex> deck = Cards.create_deck
        iex> { hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]

    """
    def deal(deck, hand_size) do
        Enum.split(deck,hand_size)
    end

    def save(deck, filename) do
        binary = :erlang.term_to_binary(deck)
        File.write(filename, binary)
    end

    def load(filename) do  
        case File.read(filename) do
            {:ok, binary } -> :erlang.binary_to_term binary
            {:error, _reason} -> "Hmm.. that file does not exist"
        end       
    end

    def create_hand(hand_size) do
        Cards.create_deck
        |> Cards.shuffle
        |> Cards.deal(hand_size)
    end
end

