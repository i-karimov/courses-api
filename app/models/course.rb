class Course < ApplicationRecord
  belongs_to :author

  validate :title, presence: true
end
