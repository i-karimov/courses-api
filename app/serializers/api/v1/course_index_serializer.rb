module Api
  module V1
    class CourseIndexSerializer < ActiveModel::Serializer
      attributes :id, :title, :author_id
    end
  end
end