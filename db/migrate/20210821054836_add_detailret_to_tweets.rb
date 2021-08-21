class AddDetailretToTweets < ActiveRecord::Migration[5.2]
  def change
    add_column :tweets, :retweet_rf, :integer, foreign_key: true
  end
end
