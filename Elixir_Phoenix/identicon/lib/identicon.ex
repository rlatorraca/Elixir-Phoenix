defmodule Identicon do
  @moduledoc """
  Documentation for `Identicon`.
  This is simple going to build a Identiicon similar we can see on GitHub pages.
  Those personal icons are 5 squares x 5 squares and simetrics
  We are going to use md5 has code to generate a unique sequence that we are going to get and
    to transform in a colored or not square
  It sequence of hash created is used to filling up the square sequence below

  ## Example

      1   2   3   2   1
      4   5   6   5   4
      7   8   9   8   7
      10  11  12  11  10
      13  14  15  14  13
  """

  @doc """
    Main function to Identicon
  """
  def main(input) do
    input
      |> hash_input
      |> pick_color
      |> build_grid
  end

  @doc """
    Calculate a hash input
  """
  def hash_input(input) do
    hash = :crypto.hash(:md5, input)
      |> :binary.bin_to_list
    %Identicon.Image{hex: hash}
  end

  @doc """
    Get the first three values of the strict to create RGB color
  """
  def pick_color(%Identicon.Image{ hex: [r, g, b | _tail] } = hash) do
   #%Identicon.Image{hex: [r, g, b | _tail] } = hash
   %Identicon.Image{ hash | color: {r,g,b} }
  end

  ## Using JS
  # pick_color: function(image){
  #   image.color = {
  #     r: image.hex[0],
  #     g: image.hex[1],
  #     b: image.hex[2],
  #   };
  #   return image
  #}

  @doc """
    Convert a hash code in chunks of 5 lines x 5 lines, duplicating the last two numbers,
      getting the second and firt numbers respectively.
    And, deleting the last element
  """
  def build_grid(%Identicon.Image{ hex: hex_list } = hash) do
    hex_list
      |> Enum.chunk_every(3)
  end


end
