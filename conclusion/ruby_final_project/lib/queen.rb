# frozen_string_literal: true

require_relative 'piece'
require_relative 'direction_set'

# Parent class for white and black queens
class Queen < Piece
  include DirectionSet

  private

  attr_reader :directions

  public

  def initialize(board, location, color)
    super
    @directions = [-1, 0, 1].repeated_permutation(2).to_a.reject { |arr| arr == [0, 0] }
  end

  def set_valid_moves
    # non-captures
    @valid_moves = find_valid_moves(directions)
  end

  def set_valid_captures
    # Does not safeguard against capturing opponents king because it cannot be in check
    @valid_captures = find_valid_captures(directions)
  end

  def to_s
    white? ? '♛'.gray : '♛'.black
  end
end

# White Queen
class WhiteQueen < Queen
  def initialize(board, location)
    super(board, location, 'white')
    @identifier = 'c'
  end

  def points(square = location)
    900 + WHITE_QUEEN_TABLE[square]
  end
end

# Black Queen
class BlackQueen < Queen
  def initialize(board, location)
    super(board, location, 'black')
    @identifier = 'd'
  end

  def points(square = location)
    -900 - BLACK_QUEEN_TABLE[square]
  end
end
