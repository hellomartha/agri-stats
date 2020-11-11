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

  def edit
    @resource = Result.find(params[:id])
  end

  def new_resource
    x = Result.new
    ([*(1..7)]*2).sort.each do|num|
      x.picks.build(pick_number: num)
    end
    x
  end

  def create
    x = permit_params
    @resource = Result.new(x)
    @resource.user = current_user if current_user.present?
    @resource.picks.each{|p|
      p.result = @resource
    }
    if @resource.save
      flash[:success] = "登録しました"
      redirect_to result_path(id: @resource.id)
    else
      [*(1..7)].each do|num|
        (2 - @resource.picks.filter{|i| i.pick_number == num}.size).times{
          @resource.picks.build(pick_number: num)
        }
      end
      @resource.picks.target.sort_by!(&:pick_number)
      render 'new'
    end
  end

  def show
    @resource = Result.find(params[:id])
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
