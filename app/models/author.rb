class Author < ApplicationRecord
  before_destroy ->(_author) { raise "Move the logic of orphan courses` author reassignment logic to layer above" }

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
end
