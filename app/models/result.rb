class Result < ApplicationRecord
  belongs_to :user, optional: true
  has_many :picks, -> {order("pick_number ASC")}, dependent: :destroy
  accepts_nested_attributes_for :picks

  after_save :update_card_stats
  after_destroy :update_card_stats

  validates :player, :rank, :score, :turn_number, presence: true

  def update_card_stats
    picks.each do|p|
      p.card.update_stats
    end
  end
end

