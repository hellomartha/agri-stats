class User < ApplicationRecord
  def game_count
    Result.where(user: self).count
  end
  def win_count
    Result.by_user(self).where(rank: 1).count
  end
  def win_rate
    return 0 if game_count == 0
    win_count.fdiv(game_count)
  end
  def score_total
    Result.by_user(self).pluck(:score).sum
  end
  def score_ave
    return 0 if game_count == 0
    score_total.fdiv(game_count)
  end
  def rankscore_ave
    results = Result.by_user(self).where.not(player: 1) 
    total = results.map{|r|
      1 - ((r.rank.to_f-1)/(r.player.to_f-1))
    }.sum
    total/results.count
  end
  def turnscore_ave
    results = Result.by_user(self).where.not(player: 1) 
    total = results.map{|r|
      1-((r.turn_number.to_f-1)/(r.player.to_f-1))
    }.sum
    total/results.count
  end
end
