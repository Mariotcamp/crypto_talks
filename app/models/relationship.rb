class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "EndUser"
  belongs_to :followed, class_name: "EndUser"
  validates :follower_id, presence: true
  validates :followed_id, presence: true
end
