class Pick < ApplicationRecord
  belongs_to :card
  belongs_to :result

  attr_accessor :deck, :number

  def deck
    card&.number[0]
  end

  def number
    card&.number[1..3].to_i
  end
end

