module Api
  module V1
    class Authors::CoursesController < ApplicationController
      before_action :set_author!
      before_action :set_course!, only: [ :show, :update, :destroy ]

      def show
        render json: @course, serializer:
      end

      def create
        @course = @author.courses.new(course_params)

        if @course.save
          render json: @course, status: :created, serializer:
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      def update
        if @course.update(course_params)
          render json: @course, serializer:
        else
          render json: @course.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @course.destroy
        head :no_content
      end

      private

      def set_author!
        @author = Author.find(params[:author_id])
      end

      def set_course!
        @course = @author.courses.find(params[:id])
      end

      def course_params
        params.require(:course).permit(:title, :description, :content)
      end

      def serializer
        CourseSerializer
      end
    end
  end
end
