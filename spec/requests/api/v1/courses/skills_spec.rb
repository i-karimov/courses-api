require 'swagger_helper'

RSpec.describe '/api/v1/courses/skills', type: :request do
  path '/api/v1/courses/{course_id}/skills' do
    parameter name: 'course_id', in: :path, type: :string, description: 'ID курса'

    get 'Получить список компетенций курса' do
      tags 'Компетенции курса'
      produces 'application/json'

      response '200', 'Успешный запрос' do
        let(:author) { create(:author) }
        let(:course_id) { create(:course, author:, skills: create_list(:skill, 3)).id }

        run_test!
      end
    end

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

      response '201', 'Компетенция создана' do
        let(:course_id) { create(:course).id }
        let(:skill) { { name: 'New Skill', description: 'Description of the new skill' } }

        run_test!
      end

      response '422', 'Недопустимый запрос' do
        let(:course_id) { create(:course).id }
        let(:skill) { { name: nil } }

        run_test!
      end
    end
  end

  path '/api/v1/courses/{course_id}/skills/{skill_id}' do
    parameter name: 'course_id', in: :path, type: :string, description: 'ID курса'
    parameter name: 'skill_id', in: :path, type: :string, description: 'ID компетенции'

    delete 'Удаляет компетенцию у курса' do
      tags 'Компетенции курса'

      response '204', 'Компетенция курса удалена' do
        let(:course_id) { create(:course).id }
        let(:skill_id) { create(:skill).id }
        before do
          create(:course_skill, course_id:, skill_id:)
        end

        run_test!
      end

      response '404', 'Компетенция не найдена' do
        let(:course_id) { create(:course).id }
        let(:skill_id) { 'invalid' }

        run_test!
      end
    end
  end
end
