class User < ActiveRecord::Base

  has_many :friendships_requested, class_name: "Friendship", foreign_key: :user_id
  has_many :friendees, through: :friendships_requested, source: :friendee

  has_many :friendships_received, class_name: "Friendship", foreign_key: :friendee_id
  has_many :frienders, through: :friendships_received, source: :user

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def accepted_friendships
    friendships_requested.confirmed + friendships_received.confirmed
  end

  def friends
    friends_array = []

    accepted_friendships.each do |friendship|
      friends_array << friendship.find_friend_of(self)
    end

    friends_array
  end
end
