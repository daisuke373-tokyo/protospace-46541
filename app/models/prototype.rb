class Prototype < ApplicationRecord
	belongs_to :user
  has_one_attached :main_image
  has_many :comments, dependent: :destroy

  validates :title, presence: true
  validates :catch_copy, presence: true
  validates :concept, presence: true
  validates :main_image, presence: true

end
