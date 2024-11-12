CourseSkill.destroy_all
Course.destroy_all
Skill.destroy_all
Author.destroy_all

10.times do
  author = FactoryBot.create(:author)
  3.times do
    course = FactoryBot.create(:course, author: author)
    2.times do
      skill = FactoryBot.create(:skill)
      FactoryBot.create(:course_skill, course: course, skill: skill)
    end
  end
end