class Author < ApplicationRecord
  before_destroy ->(_author) { raise "Implement the logic of orphan courses` author reassignment on layer above" }

  has_many :courses

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true # todo: validate format
end
