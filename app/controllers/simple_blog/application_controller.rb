module SimpleBlog
  class ApplicationController < ActionController::Base
    private

      def not_found
        raise ActionController::RoutingError.new('Not Found')
      end
  end
end
