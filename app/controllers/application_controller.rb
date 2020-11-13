class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :render_404

  def model
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def columns_of_show
    model.attribute_names
  end

  def render_404
    render template: 'application/page_not_found'
  end
end
