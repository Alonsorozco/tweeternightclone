class User < ApplicationRecord
  has_many  :tweet, dependent: :destroy#tiene muchos dueños
  has_many :Likes, dependent: :destroy #tiene muchos dueños

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :followeds, class_name: 'Follow', foreign_key: :follower_id, dependent: :destroy#SEGUIDO
  has_many :followers, class_name: 'Follow', foreign_key: :followed_id, dependent: :destroy#SEGUIDOR
 
  def can_follow
    User.where.not(id: followeds.map(&:followed_id)).limit(4)

  end

  

end
