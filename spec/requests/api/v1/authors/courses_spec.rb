require 'swagger_helper'

RSpec.describe 'Api::V1::Authors::Courses', type: :request do
  path '/api/v1/authors/{author_id}/courses' do
    parameter name: 'author_id', in: :path, type: :integer, required: true, description: 'Author ID'

    post 'Create a course' do
      let(:author_id) { create(:author).id }
      let(:course) { attributes_for(:course) }

      tags 'Courses'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :course, in: :body, schema: {
        type: :object,
        required: [ 'title', 'description' ],
        properties: {
          title: { type: :string },
          description: { type: :string }
        }
      }

      response '201', 'course created' do
        run_test!
      end

      response '422', 'invalid request' do
        let(:course) { { title: nil, description: nil } }
        run_test!
      end
    end
  end

  path '/api/v1/authors/{author_id}/courses/{id}' do
    parameter name: 'author_id', in: :path, type: :integer, required: true, description: 'Author ID'
    parameter name: 'id', in: :path, type: :integer, required: true, description: 'Course ID'

    get 'Show a course' do
      tags 'Courses'
      produces 'application/json'

      response '200', 'successful' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:course) { create(:course, author: author) }
        let(:id) { course.id }

        run_test!
      end

      response '404', 'not found' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:id) { 'invalid' }

        run_test!
      end
    end

    put 'Update a course' do
      tags 'Courses'
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

      response '200', 'successful' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:course) { create(:course, author: author) }
        let(:id) { course.id }
        let(:course_params) { { title: 'Updated Course', description: 'Updated description' } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let!(:persisted_course) { create(:course, author: author) }
        let(:id) { persisted_course.id }
        let(:course) { { title: nil } }

        run_test!
      end

      response '404', 'not found' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:id) { 'invalid' }
        let(:course) { nil }

        run_test!
      end
    end

    delete 'Delete a course' do
      tags 'Courses'

      response '204', 'successful' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:course) { create(:course, author: author) }
        let(:id) { course.id }

        run_test!
      end

      response '404', 'not found' do
        let(:author) { create(:author) }
        let(:author_id) { author.id }
        let(:id) { 'invalid' }

        run_test!
      end
    end
  end
end