class Bookmark < ApplicationRecord
  belongs_to :movie
  belongs_to :list

  validates :comment, length: { minimum: 6, message: 'make a longer comment biatch' }
  validates :movie_id, uniqueness: { scope: :list_id, message: 'is already in the list biatch' }
end
