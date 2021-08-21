class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy quote ]

  # GET /tweets or /tweets.json
  def index
    @user_likes = Like.where(user: current_user).pluck(:tweet_id)
    @tweet = Tweet.new
    @tweets = Tweet.order(created_at: :desc).page params[:page]
   
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  
  end
  def quote
    @quote = Tweet.new

    @quote.content = @tweet.content
    @quote.user_id = current_user.id
    @quote.retweet_rf = @tweet.id
    @quote.created_at = DateTime.now
    @quote.updated_at = DateTime.now
    respond_to do |format|
      if @quote.save
        format.html { redirect_to root_path, notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id #se guarda el usuario y el tweet
    respond_to do |format|
      if @tweet.save
        format.html { redirect_to root_path, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end

  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def likeLike
      @like = Like.all
    end
    
    

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end
end