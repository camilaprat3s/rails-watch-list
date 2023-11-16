class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :restrict_with_error
  validates :title, presence: true, uniqueness: true
  validates :overview, presence: true
  def destroy
    raise ActiveRecord::InvalidForeignKey if bookmarks.exists?

    super
  end
end
