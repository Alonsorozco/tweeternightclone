class FollowsController < ApplicationController

def to_follow

    @followed = User.find(params[:id])
    redirect_to root_path if current_user.banned?
    new_follow = Follow.create!(follower: current_user, followed: @followed)    
    redirect_to root_path
end

end
