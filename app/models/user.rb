class User < ApplicationRecord
  def game_count
    Result.where(user: self).count
  end
  def win_count
    Result.where(user: self, rank: 1).count
  end
  def win_rate
    return 0 if game_count == 0
    win_count.fdiv(game_count)
  end
  def score_total
    Result.where(user: self).pluck(:score).sum
  end
  def score_ave
    return 0 if game_count == 0
    score_total.fdiv(game_count)
  end
end

