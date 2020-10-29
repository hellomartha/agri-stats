class Pick < ApplicationRecord
  belongs_to :card
  belongs_to :result

  attr_accessor :deck, :number
end

