class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy quote ]
  before_action :authenticate_user!,only: %i[ quote ] #solo usuario authentificado pueden dar rteetear


  # GET /tweets or /tweets.json
  def index
    # Buqueda parcial
    if params[:q]
      @tweets = Tweet.where('content LIKE ?', "%#{params[:q]}%").order(created_at: :desc).page params[:page]
    elsif user_signed_in?
      @tweets = Tweet.tweets_for_me(current_user).order(created_at: :desc).page params[:page]
    else
      @tweets= Tweet.eager_load(:user, :likes).order(created_at: :desc).page params[:page]
    end
    @tweet = Tweet.new
    @user_likes = Like.where(user: current_user).pluck(:tweet_id)
    @users = User.where('id IS NOT ?', current_user.id) if user_signed_in?
  end
  # GET /tweets/1 or /tweets/1.json
  def show
    @tweet_likes = @tweet.likes
  end


  def quote
    @quote = Tweet.new

    @quote.content = @tweet.content # se cargar el  content tweet a quote
    @quote.user_id = current_user.id # se cargar el curren user a la columna user id del quote
    @quote.tweet_id = @tweet.id # se cargar el tweet.id a quote
    @quote.created_at = DateTime.now #se cargar la fecha creacion a quote
    @quote.updated_at = DateTime.now #se cargar la fecha de actualizacion a quote
    respond_to do |format| #se direcciona al root
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
    respond_to do |format|#redirrecciona al root
      if @tweet.save
        format.html { redirect_to root_path, notice: "Felicitaciones has twitteado" }
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
    

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :user_id)
    end
end
