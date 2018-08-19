class Post < ApplicationRecord
  validates :title, presence: true, length: { minimum: 5 }
  validates_presence_of :body

  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :tags, dependent: :destroy
  accepts_nested_attributes_for :tags, allow_destroy: true, reject_if: ->(attrs){ attrs['name'].blank? }
  scope :ordenados, ->() { order(created_at: :desc) }
  
  def self.p_user(u_id)
    joins(:user).select(:id,:email,:created_at,:title ,:body,:user_id).find_by(id: u_id)
  end
end
