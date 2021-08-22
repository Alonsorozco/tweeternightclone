class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :tweets



  def rt_count

    Tweet.where(tweet_id: self.id).count
    
  end


end
