module Api
  module V1
    class SkillsController < ApplicationController
      def index
        @pagy, skills = pagy(Skill.all)
        render json: skills, each_serializer:
      end

      def create
        @skill = Skill.new(skill_params)

        if @skill.save
          render json: @skill, status: :created, serializer:
        else
          render json: @skill.errors, status: :unprocessable_entity
        end
      end

      def destroy
        skill = Skill.find(params[:id])
        skill.destroy

        head :no_content
      end

      private

      def skill_params
        params.require(:skill).permit(:name, :description)
      end

      def each_serializer
        serializer
      end

      def serializer
        SkillSerializer
      end
    end
  end
end
