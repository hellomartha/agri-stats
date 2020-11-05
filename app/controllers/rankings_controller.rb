class RankingsController < ApplicationController
  def model
    Card
  end

  def index
    category = params[:category] || "all"
    @cards = Card.picked.page(params[:page]).per(20).try(category.to_sym)

    case params[:sorted_by] 
    when "win_rate" then
      @cards = @cards.order(win_rate: "DESC", number: "ASC") 
    when "use_rate" then
      @cards = @cards.order(use_rate: "DESC", number: "ASC") 
    when "score_ave" then
      @cards = @cards.order(score_ave: "DESC", number: "ASC") 
    when "pick_ave" then
      @cards = @cards.order(pick_ave: "DESC", number: "ASC") 
    when "number" then
      @cards = @cards.order(number: "ASC") 
    when "name" then
      @cards = @cards.order(name_ja: "ASC") 
    else
      @cards = @cards.order(win_rate: "DESC", number: "ASC") 
    end
    @cards
  end
end
