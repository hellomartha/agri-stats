class Card < ApplicationRecord
  scope :picked, -> {where(num_of_pick: 1..Float::INFINITY)}
  scope :occupations, -> {where(category:"職業")}
  scope :improvements, -> {where(category:"小進歩")}

  def update_stats
    card_id = self.id
    picks = Pick.includes(:card, :result).joins(:card, :result).where(card_id: card_id)
    num_of_pick = picks.count
    used_picks = picks.where(used: true)
    num_of_use = used_picks.count
    num_of_win = used_picks.where("results.rank": 1).count
    sum_of_score = used_picks.pluck("results.score").compact.sum
    sum_of_pick = picks.pluck(:pick_number).compact.sum

    win_rate = (num_of_use == 0) ? 0.0 : (Float(num_of_win)/Float(num_of_use))
    score_ave = (num_of_use == 0) ? 0.0 : (Float(sum_of_score)/Float(num_of_use))
    use_rate = (num_of_pick == 0) ? 0.0 : (Float(num_of_use)/Float(num_of_pick))
    pick_ave = (num_of_pick == 0) ? 0.0 : (Float(sum_of_pick)/Float(num_of_pick))

    self.update(
      num_of_pick: num_of_pick,
      num_of_use: num_of_use,
      num_of_win: num_of_win,
      sum_of_score: sum_of_score,
      sum_of_pick: sum_of_pick,
      win_rate: win_rate,
      use_rate: use_rate,
      score_ave: score_ave,
      pick_ave: pick_ave
    )
  end
end
