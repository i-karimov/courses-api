# app/controllers/api/v1/courses/skills_controller.rb

module Api
  module V1
    class Courses::SkillsController < ApplicationController
      before_action :set_course!

      def index
        @skills = @course.skills
        render json: @skills
      end

      def create
        @skill = Skill.find_or_create_by(name: skill_params[:name])

        if @course.skills << @skill
          render json: @skill, status: :created
        else
          render json: @skill.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @skill = @course.skills.find(params[:id])
        @course.skills.destroy(@skill)
        head :no_content
      end

      private

      def set_course!
        @course = Course.find(params[:course_id])
      end

      def skill_params
        params.require(:skill).permit(:name, :description)
      end
    end
  end
end