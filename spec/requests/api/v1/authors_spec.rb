require 'swagger_helper'

RSpec.describe 'api/v1/authors', type: :request do
    path '/api/v1/authors' do
      get('list authors') do
        response(200, 'successful') do
          after do |example|
            example.metadata[:response][:content] = {
              'application/json' => {
                example: JSON.parse(response.body, symbolize_names: true)
              }
            }
          end
          run_test! do
          end
        end
      end

    post('create author') do
      let(:author) { attributes_for(:author) }

      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string }
        },
        required: [ 'first_name', 'last_name', 'email' ]
      }

      response(201, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        it "creates deadline_request" do |example|
          expect { submit_request(example.metadata) }.to change(Author, :count).by(1)
          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'missing mandatory fields' do
        let(:author) { { first_name: 'John' } }

        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('show author') do
      produces "application/json"
      response(200, 'successful') do
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        let!(:id) { Author.create(first_name: 'Jane', last_name: 'Doe', email: 'jane.doe@example.com').id }
        run_test!
      end
    end



    patch('update author') do
      before do
        create(:author, id: 123)
      end

      consumes 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string }
        }
      }

      response(200, 'successful') do
        let(:id) { 123 }
        let(:author) { attributes_for(:author) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end

    put('update author') do
      before do
        create(:author, id: 123)
      end

      consumes 'application/json'
      parameter name: :author, in: :body, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string }
        },
        require: [ 'first_name', 'last_name', 'email' ]
      }

      response(200, 'successful') do
        let(:id) { 123 }
        let(:author) { attributes_for(:author) }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end

        run_test!
      end
    end

    delete('delete author') do
      before do
        create(:author, id: 123)
      end

      response(204, 'successful') do
        let(:id) { 123 }

        run_test!
      end
    end
  end
end
