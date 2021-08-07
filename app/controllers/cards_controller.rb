class CardsController < ApplicationController
  def model
    Card
  end

  def resource
    Card.find(params[:id])
  end

  def columns_of_show
    [
      :number, :category, :name_ja, :name_en,
      :num_of_pick, :num_of_use, :num_of_win, :win_rate_percent,
      :use_rate_percent, :score_ave, :pick_ave
    ]
  end

  def show
    @resource = resource
  end
end
