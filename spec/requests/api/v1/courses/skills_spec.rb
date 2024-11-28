require 'swagger_helper'

RSpec.describe '/api/v1/courses/skills', type: :request do
  path '/api/v1/courses/{course_id}/skills' do
    parameter name: 'course_id', in: :path, type: :string, description: 'ID of the course'

    post 'Создание компетенции для курса' do
      tags 'Компетенции курса'
      consumes 'application/json'
      parameter name: :skill, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          description: { type: :string }
        },
        required: [ 'name' ]
      }

      response '201', 'skill created' do
        let(:course_id) { create(:course).id }
        let(:skill) { { name: 'New Skill', description: 'Description of the new skill' } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:course_id) { create(:course).id }
        let(:skill) { { name: nil } }

        run_test!
      end
    end
  end

  path '/api/v1/courses/{course_id}/skills/{skill_id}' do
    parameter name: 'course_id', in: :path, type: :string, description: 'ID of the course'
    parameter name: 'skill_id', in: :path, type: :string, description: 'ID of the skill'

    delete 'Deltes a skill for a course' do
      tags 'Компетенции курса'

      response '204', 'skill deleted' do
        let(:course_id) { create(:course).id }
        let(:skill_id) { create(:skill).id }
        before do
          create(:course_skill, course_id:, skill_id:)
        end

        run_test!
      end

      response '404', 'skill not found' do
        let(:course_id) { create(:course).id }
        let(:skill_id) { 'invalid' }

        run_test!
      end
    end
  end
end
