class CreateCourseSkills < ActiveRecord::Migration[7.2]
  def change
    create_table :course_skills do |t|
      t.references :course, null: false, foreign_key: true
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
