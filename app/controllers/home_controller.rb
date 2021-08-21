class HomeController < ApplicationController
  def index
    @tweet = Tweet.new
  end

  
end
