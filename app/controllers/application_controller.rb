class ApplicationController < ActionController::Base
  def model
    raise NotImplementedError.new("You must implement #{self.class}##{__method__}")
  end

  def columns_of_show
    model.attribute_names
  end
end
