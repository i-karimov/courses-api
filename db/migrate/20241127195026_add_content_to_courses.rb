class AddContentToCourses < ActiveRecord::Migration[7.2]
  def change
    add_column :courses, :content, :text
  end
end
