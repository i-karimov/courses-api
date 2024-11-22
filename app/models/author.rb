class Author < ApplicationRecord
  has_many :courses

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, 'valid_email2/email': true
end
