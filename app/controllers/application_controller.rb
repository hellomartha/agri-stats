class ApplicationController < ActionController::Base
  include SessionsHelper
  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  helper_method :admin?

  def model
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def columns_of_show
    model.attribute_names
  end

  def render_404
    render template: 'application/page_not_found'
  end

  def admin?
    current_user&.id == 1 && current_user&.uid == "347816803"
  end
  
  def check_admin
    render_404 unless admin?
  end
end
