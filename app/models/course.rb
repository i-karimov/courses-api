class Course < ApplicationRecord
  belongs_to :author

  has_many :course_skills
  has_many :skills, through: :course_skills

  validates :title, presence: true
end
