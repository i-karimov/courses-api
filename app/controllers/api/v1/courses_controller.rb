module Api
  module V1
    class CoursesController < ApplicationController
      def index
        @pagy, courses = pagy(Course.all)
        render json: courses, each_serializer:
      end

      def show
        author = Course.find(params[:id])

        render json: author, serializer:
      end

      private

      def each_serializer
        CourseIndexSerializer
      end

      def serializer
        CourseSerializer
      end
    end
  end
end
