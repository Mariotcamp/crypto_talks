class Favorite < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

  validates_uniqueness_of :post_id, scope: :end_user_id
end
