class SimpleBlog::ApplicationController < ApplicationController
  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
