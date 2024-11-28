class Api::V1::SkillSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
end
