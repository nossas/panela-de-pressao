Before('@ssi') do
  class ApplicationController < ActionController::Base
    def current_user
      @current_user ||= User.find_by_email("ssi@meurio.org.br")
    end
  end
end

After('@ssi') do
  class ApplicationController < ActionController::Base
    def current_user
      nil
    end
  end
end
