class Api::V1::AuthorIndexSerializer < ActiveModel::Serializer
  attributes :id, :email, :first_name, :last_name
end
