class Api::V1::AuthorsController < ApplicationController
  def index
    @pagy, authors = pagy(Author.all)
    render json: authors, each_serializer: serializer
  end

  def show
    author = Author.find(params[:id])

    render json: author, serializer:
  end

  def create
    author = Author.includes(:courses).new(author_params)

    if author.save
      render json: author, status: :created, serializer:
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  def update
    author = Author.find(params[:id])

    if author.update(author_params)
      render json: author, serializer:
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    author = Author.find(params[:id])
    result = Authors::DestroyCommand.new(ex_author: author).call

    if result.success?
      render json: result.value!, serializer:
    else
      render json: result.failure, status: :internal_server_error
    end
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :email)
  end

  def serializer
    AuthorSerializer
  end
end
