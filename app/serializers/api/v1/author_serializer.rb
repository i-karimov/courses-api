class Api::V1::AuthorSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name

  has_many :courses
end
