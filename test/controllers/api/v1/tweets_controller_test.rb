require 'test_helper'

class Api::V1::TweetsControllerTest < ActionDispatch::IntegrationTest
  test "should get news" do
    get api_v1_tweets_news_url
    assert_response :success
  end

end
