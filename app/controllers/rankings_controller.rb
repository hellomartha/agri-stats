class RankingsController < ApplicationController
  def model
    Card
  end

  def index
    category = params[:category] || "all"
    @cards = Card.try(category.to_sym).picked.page(params[:page]).per(100)

    case params[:sorted_by] 
    when "win_rate" then
      @cards = @cards.order(win_rate: "DESC", num_of_pick: "DESC", number: "ASC") 
    when "use_rate" then
      @cards = @cards.order(use_rate: "DESC", num_of_pick: "DESC", number: "ASC") 
    when "score_ave" then
      @cards = @cards.order(score_ave: "DESC", num_of_pick: "DESC", number: "ASC") 
    when "pick_ave" then
      @cards = @cards.order(pick_ave: "ASC", num_of_pick: "DESC", number: "ASC") 
    when "number" then
      @cards = @cards.order(number: "ASC") 
    when "name" then
      @cards = @cards.order(name_ja: "ASC", name_en: "ASC", number: "ASC") 
    when "num_of_pick" then
      @cards = @cards.order(num_of_pick: "DESC") 
    else
      @cards = @cards.order(num_of_pick: "DESC", win_rate: "DESC", number: "ASC") 
    end
    @cards
  end
end
