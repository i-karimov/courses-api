module Api
  module V1
    class CourseSerializer < ActiveModel::Serializer
      attributes :id, :title, :content

      belongs_to :author
      has_many :skills
    end
  end
end
