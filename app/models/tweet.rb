class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :tweets
  paginates_per 50



#metodo para buscar las imagenes 
  def father_avatar

    Tweet.find(self.tweet_id).user.url_photo

  end

  #metodo para buscar los nombre de las personas del tweet que retwittea
  def father_name
    
    Tweet.find(self.tweet_id).user.username
    
  end
  

end
