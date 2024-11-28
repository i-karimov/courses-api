CourseSkill.destroy_all
Course.destroy_all
Skill.destroy_all
Author.destroy_all

skills = FactoryBot.create_list(:skill, 30)

20.times do
  author = FactoryBot.create(:author)
  3.times do
    course = FactoryBot.create(:course, author: author)
    4.times do
      FactoryBot.create(:course_skill, course: course, skill: skills.sample)
    end
  end
end