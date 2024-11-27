module Api
  module V1
    class CourseSerializer < ActiveModel::Serializer
      attributes :id, :title
    end
  end
end