class Result < ApplicationRecord
  has_many :picks, dependent: :destroy
  accepts_nested_attributes_for :picks

  after_save :update_card_stats
  after_destroy :update_card_stats

  def update_card_stats
    picks.each do|p|
      p.card.update_stats
    end
  end
end

