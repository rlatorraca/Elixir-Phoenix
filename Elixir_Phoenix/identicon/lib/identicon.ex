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
      |> filter_odd_squares
      |> build_pixel_map
      |> draw_image
      |> save_image(input)
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
      getting the second and first numbers respectively.
    And, deleting the last element
  """
  def build_grid(%Identicon.Image{ hex: hex_list } = hash) do
    grid =
      hex_list
        # |> Enum.chunk(3) #Bulding maps with rows of 3 elements - DEPRECATED
          |> Enum.chunk_every( 3, 3, :discard)  #Bulding maps with rows of 3 elements
          |> Enum.map(&mirror_row/1)
          |> List.flatten                       # Convert to a list
          |> Enum.with_index                    # Put on a index for each position in a tuple (will be important to color the squares

    %Identicon.Image{ hash | grid: grid}
  end

  @doc """
    Duplicate the first and second element in put into fifth and fourth (respectively) position on the row an then
    We can see the row having 5 elements instead 3 elements
  """
  def mirror_row(row) do
    # From [ x, y, x]
    [first, second | _tail] = row

    # To [ x, y, z, y, x]
    row ++ [ second, first]
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = hash) do
    grid = Enum.filter(grid, fn({code,_index}) ->
      rem(code, 2) == 0 # return just even numbers (0,2,4,6 and so on)
    end)
    %Identicon.Image{ hash | grid: grid}
  end

  def build_pixel_map(%Identicon.Image{grid: grid} = hash) do
    pixel_map =
      Enum.map(grid, fn({_code, index}) ->
        horizontal = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizontal, vertical}
        bottom_right = {horizontal + 50, vertical + 50}

        {top_left, bottom_right }
      end)
      %Identicon.Image{hash | pixel_map: pixel_map}
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    # :egd is Erlang function that we gonna use to draw big and principal lines of the square
    image = :egd.create(250,250)
    fill_color = :egd.color(color)

    Enum.each pixel_map, fn({top_left, bottom_right}) ->
      :egd.filledRectangle(image, top_left, bottom_right, fill_color)
    end

    :egd.render(image)
  end

  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

end

