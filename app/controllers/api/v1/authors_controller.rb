class Api::V1::AuthorsController < ApplicationController
  def index
    @pagy, @authors = pagy(Author.all)
    render json: @authors
  end

  def show
    @author = Author.find(params[:id])
    render json: @author
  end

  def create
    @author = Author.new(author_params)
    if @author.save
      render json: @author, status: :created
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def update
    @author = Author.find(params[:id])
    if @author.update(author_params)
      render json: @author
    else
      render json: @author.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @author = Author.find(params[:id])
    @author.destroy
    head :no_content
  end

  private

  def author_params
    params.require(:author).permit(:first_name, :last_name, :email)
  end
end
