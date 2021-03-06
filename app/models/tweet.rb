class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :tweets
  paginates_per 50
  #scope :tweets_for_me, -> (user) { where(user_id:  user.followeds.ids)}
  scope :tweets_for_me, -> (user) { where(:user_id => user.followeds.pluck(:followed_id)) } #scope para que muetrrea mis tweets y los de mi amigos

  # Ex:- scope :active, -> {where(:active => true)}
  validates :content, presence: true


#metodo para buscar las imagenes 
  def father_avatar

    Tweet.find(self.tweet_id).user.url_photo

  end

  #metodo para buscar los nombre de las personas que retwittea
  def father_name
    
    Tweet.find(self.tweet_id).user.username
    
  end
  
    def count_tweet
      
      Tweet.where(tweet_id: self.id).count
      
    end
    
end
