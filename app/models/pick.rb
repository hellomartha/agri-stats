class Pick < ApplicationRecord
  belongs_to :card
  belongs_to :result

  attr_accessor :deck, :number

  def deck
    card&.number[0] if card&.number.present?
  end

  def number
    card&.number[1..3].to_i if card&.number.present?
  end
end

