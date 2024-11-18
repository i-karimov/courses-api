class Api::V1::AuthorsController < ApplicationController
  before_action :set_author!, only: [ :show, :update, :destroy ]
  def index
    @pagy, authors = pagy(Author.all)
    render json: authors
  end

  def show
    render json: @author
  end

  def create
    author = Author.new(author_params)

    if author.save
      render json: author, status: :created
    else
      render json: author.errors, status: :unprocessable_entity
    end
  end

  def update
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    result = Authors::DestroyCommand.new(ex_author: @author).call

    if result.success?
      render json: result.value!
    else
      render json: result.failure, status: :internal_server_error
    end
  end

  private

  def set_author!
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:first_name, :last_name, :email)
  end
end
