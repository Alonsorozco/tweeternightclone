class Api::V1::TweetsController < ApplicationController   
#class Api::V1::TweetsController < ActionController::API 
  include ActionController::HttpAuthentication::Basic::ControllerMethods 
  http_basic_authenticate_with name: "fabi", password: "123123", except: :index
  skip_before_action :verify_authenticity_token

  #cambiar herencia aplicationcontroller
  def news
    #creamos el hash para mostrar los datos en la api
    @tweet = Tweet.all 
    api = []
    @tweet.each do |tweet|
      api << Hash[:id => tweet.id, :content => tweet.content, :user_id => tweet.user_id, :likes_count => tweet.likes.count,:retweets_count => tweet.count_tweet,:rewtitted_from => tweet.tweet_id]
    end
    @tweets = api.last(50)#ultimos50 tweets
    render json: @tweets 
  end 

  def date_filter
    #busqueda de tweets segun fechas
    @tweets = Tweet.where("created_at >= ? AND created_at <= ?", params[:date1].to_date.beginning_of_day, params[:date2].to_date.end_of_day)
    render json: @tweets  
    
  end

  def create
    #creat un tweet para el usuraio id 3 
    @tweets =  User.find(3).tweet.create(content: params[:content])
    render json: @tweets 

  end
  
  
end
