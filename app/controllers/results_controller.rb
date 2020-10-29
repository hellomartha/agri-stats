class ResultsController < ApplicationController
  def model
    @model = Result
  end
  def index
    @resources = Result.all
  end
  
  def new
    @resource ||= new_resource
  end

  def new_resource
    x = Result.new
    14.times {x.picks.build}
    x
  end

  def create
    @resource = Result.new(permit_params)
    if @resource.save
      flash[:success] = "登録しました"
      redirect_to "/"
    else
      render 'new'
    end
  end

  def permit_params
    @send_params = params.require(:result)
    x=params.require(:result)["picks_attributes"]
    y = ActionController::Parameters.new(
      (0..13).map.with_index do|i|
        next if x.values[i][:deck].empty? || x.values[i][:number].empty?
        z = Card.find_by(number: "#{x.values[i][:deck]}#{format('%03d',x.values[i][:number].to_i)}")
        next if z.nil?
        ["#{i}", {"deck" => x.values[i][:deck], "number" => x.values[i][:number], "used" => x.values[i][:used], "pick_number" => (1+i/2).ceil,"card_id" => z&.id}]
      end.compact.to_h
    )
    params.require(:result)["picks_attributes"] = y
    params.require(:result).permit(
      :player,
      :turn_number,
      :rank,
      :score,
      picks_attributes: [:id, :result_id, :card_id, :pick_number, :deck, :number, :used]
    )
  end
end
