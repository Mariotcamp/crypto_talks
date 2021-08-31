class Comment < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

  validates :sentence, presence: true, length: { maximum: 150 }
end
