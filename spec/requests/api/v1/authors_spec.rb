require 'swagger_helper'

RSpec.describe 'api/v1/authors', type: :request do
    path '/api/v1/authors' do
      get('Список авторов') do
        produces 'application/json'

        parameter(name: 'page', in: :query, required: false, description: 'Номер страницы', type: :integer)

        response(200, 'successful') do
          run_test!
        end
      end

    post('Создать нового автора') do
      let(:author) { attributes_for(:author) }

      consumes 'application/json'
      produces 'application/json'

      parameter name: :author, in: :body, required: true, schema: {
        type: :object,
        properties: {
          first_name: { type: :string },
          last_name: { type: :string },
          email: { type: :string }
        },
        required: [ 'first_name', 'last_name', 'email' ]
      }

      response(201, 'successful') do

        it "creates " do |example|
          expect { submit_request(example.metadata) }.to change(Author, :count).by(1)
          assert_response_matches_metadata(example.metadata)
        end
      end

      response '422', 'Отсутствуют необходимые поля' do
        let(:author) { { first_name: 'John' } }

        run_test!
      end
    end
  end

  path '/api/v1/authors/{id}' do
    parameter name: 'id', in: :path, type: :string, description: 'id'

    get('Получить данные автора') do
      description 'Возвращает данные автора вместе с его курсами'
      produces "application/json"
      response(200, 'Успешно') do
        let!(:id) { create(:author).id }

        run_test!
      end
    end

    put('Изменить данные автора') do
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
        required: [ 'first_name', 'last_name', 'email' ]
      }

      response(200, 'successful') do
        let(:id) { 123 }
        let(:author) { attributes_for(:author) }

        run_test!
      end
    end

    delete('Удалить автора') do
      produces 'application/json'
      description 'Прежде чем удалить указанного автора, находит случайного автора и назначает ему курсы удаляемого автора.'

      let(:ex_author) { create(:author) }
      let(:id) { ex_author.id }


      response(200, 'Автор успешно удален. Данные нового автора возвращаются в теле ответа.') do
        before { create(:author) }

        run_test!
      end

      context 'Если не удалос найти замену автору.' do
        response(500, 'Не удалось найти замену автора.') do
          run_test!
        end
      end
    end
  end
end
