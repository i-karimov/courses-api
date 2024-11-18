require 'rails_helper'

RSpec.describe Author, type: :model do
  describe "validations" do
    let(:author) { build(:author) }

    it "is valid" do
      expect(author).to be_valid
    end
  end
end
