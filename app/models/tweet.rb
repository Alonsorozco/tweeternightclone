class Tweet < ApplicationRecord
  belongs_to :user
  has_many :likes
  has_many :tweets

  def rt_count

    Tweet.where(retweet_rf: self.id).count
    
  end

end
