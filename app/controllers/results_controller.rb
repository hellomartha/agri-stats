class ResultsController < ApplicationController
  def model
    Result
  end
  def columns_of_show
    [
      :player, :turn_number, :rank, :score, :note
    ]
  end
  def resource
    Result.find(params[:id])
  end

  def index
    @resources = Result.all
  end
  
  def new
    @resource ||= new_resource
  end

  def edit
    @resource = resource
    @resource = build_14picks(@resource)
  end

  def destroy
    if logged_in? && ( admin? || resource.user == current_user)
      resource.destroy
      redirect_to root_url
    else
      render_404
    end
  end

  def exclude_calc
    if admin?
      resource.update(calc_target: false)
      redirect_back(fallback_location: root_path)
    else
      render_404
    end
  end

  def include_calc
    if admin?
      resource.update(calc_target: true)
      redirect_back(fallback_location: root_path)
    else
      render_404
    end 
  end

  def build_14picks(result)
    [*(1..7)].each do|num|
      (2 - result.picks.filter{|i| i.pick_number == num}.size).times{
        result.picks.build(pick_number: num)
      }
    end
    result.picks.target.sort_by!(&:pick_number)
    result
  end

  def link_picks(result)
    result.picks.each do |p|
      p.result = result
    end
    result
  end

  def new_resource
    build_14picks(Result.new)
  end

  def create
    x = permit_params
    @resource = Result.new(x)
    @resource = link_picks(@resource)
    @resource.user = current_user if current_user.present?
    if @resource.save
      flash[:success] = "登録しました"
      redirect_to result_path(id: @resource.id)
    else
      @resource = build_14picks(@resource)
      render 'new'
    end
  end

  def update
    x = permit_params
    @resource = resource
    @resource.picks=[]
    @resource.assign_attributes(x)
    @resource = link_picks(@resource)
    if @resource.save
      flash[:success] = "登録しました"
      redirect_to result_path(id: @resource.id)
    else
      @resource = build_14picks(@resource)
      render 'edit'
    end
  end

  def show
    @resource = resource
    @resource = build_14picks(@resource)
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
      :note,
      picks_attributes: [:id, :result_id, :card_id, :pick_number, :deck, :number, :used]
    )
  end
end
