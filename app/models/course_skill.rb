class CourseSkill < ApplicationRecord
  belongs_to :course
  belongs_to :skill
end
