class Post < ApplicationRecord
  validates :end_user_id, presence: true
  validates :sentence, presence: true, length: { maximum: 150 }

  belongs_to :end_user
end
