class User < ApplicationRecord
  has_many  :tweet, dependent: :destroy#tiene muchos dueños
  has_many :Likes #tiene muchos dueños

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :followeds, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy#SEGUIDO
  has_many :followers, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy#SEGUIDOR
 
  def can_follow? #puedes seguir
    should_follow = self.followeds.pluck(:follower_id) #seguidores que deberias seguir
    !should_follow.include?(self.id)
  end
  

end
