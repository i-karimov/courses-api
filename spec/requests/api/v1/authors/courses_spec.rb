require 'swagger_helper'

RSpec.describe 'V1 Author Courses API', type: :request do
  path '/api/v1/authors/{author_id}/courses' do
    parameter name: 'author_id', in: :path, type: :integer, required: true, description: 'Author ID'

    get 'Получить список курсов автора' do
      tags 'Курсы автора'
      produces 'application/json'

      response '200', 'Успешный запрос' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:courses) { create_list(:course, 3, author: author) }

        run_test!
      end

      response '404', 'Автор не найден' do
        let(:author_id) { 'author_id' }

        run_test!
      end
    end
    
    post 'Добавить автору новый курс' do
      tags "Курсы автора"
      let(:author_id) { create(:author).id }
      let(:course) { attributes_for(:course) }

      consumes 'application/json'
      produces 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        required: [ 'title', 'description' ],
        properties: {
          title: { type: :string },
          description: { type: :string },
          content: { type: :string }
        }
      }

      response '201', 'Курс успешно создан' do
        run_test!
      end

      response '422', 'Некорректный запрос' do
        let(:course) { { title: nil, description: nil } }
        run_test!
      end
    end
  end

  path '/api/v1/authors/{author_id}/courses/{id}' do
    parameter name: 'author_id', in: :path, type: :integer, required: true, description: 'Author ID'
    parameter name: 'id', in: :path, type: :integer, required: true, description: 'Course ID'

    get 'Показать курс автора' do
      tags 'Курсы автора'
      produces 'application/json'

      response '200', 'Успешный запрос' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:course) { create(:course, author: author) }
        let(:id) { course.id }

        run_test!
      end

      response '404', 'Автор или курс не найден' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put 'Обновить данные курса автора' do
      tags 'Курсы автора'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        properties: {
          title: { type: :string },
          description: { type: :string },
          content: { type: :string }
        }
      }

      response '200', 'Успешно обновлено' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:course) { create(:course, author: author) }
        let(:id) { course.id }
        let(:course_params) { { title: 'Updated Course', description: 'Updated description' } }

        run_test!
      end

      response '422', 'Недопустимый запрос' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let!(:persisted_course) { create(:course, author: author) }
        let(:id) { persisted_course.id }
        let(:course) { { title: nil } }

        run_test!
      end

      response '404', 'Курс не найден' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:id) { 'invalid' }
        let(:course) { nil }

        run_test!
      end
    end

    delete 'Удалить курс у автора' do
      tags 'Курсы автора'

      response '204', 'Успешно удалено' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:course) { create(:course, author: author) }
        let(:id) { course.id }

        run_test!
      end

      response '404', 'Курс не найден' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end