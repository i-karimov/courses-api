require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "validations" do
    let(:course) { build(:course) }
    
    it "is valid" do
      expect(course).to be_valid
    end
  end
end
