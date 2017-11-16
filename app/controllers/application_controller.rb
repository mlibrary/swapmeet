class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def newspaper
    Swapmeet.newspaper
  end
end
