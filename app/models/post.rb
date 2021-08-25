class Post < ApplicationRecord
  validates :end_user_id, presence: true
  validates :sentence, presence: true, length: { maximum: 150 }

  belongs_to :end_user
  has_many :favorites, dependent: :destroy

  def have_favorite?(end_user)
    favorites.where(end_user_id: end_user.id).exists?
  end

end
