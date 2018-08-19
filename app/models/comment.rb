class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  def self.user_comments(post_id)
    joins(:user).where(post_id: post_id).select(:id,:body, :email,:created_at,:post_id,:user_id)
  end
end
