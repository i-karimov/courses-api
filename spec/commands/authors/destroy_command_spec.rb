require 'rails_helper'

RSpec.describe Authors::DestroyCommand do
  describe '#call' do
    subject(:destroy_author) { described_class.new(ex_author:) }
    let!(:ex_author) { create :author, courses: build_list(:course, 2) }


    context "when happy path" do
      let!(:ex_author_course_ids) { ex_author.course_ids }
      let!(:delegee_author) { create :author, courses: build_list(:course, 1) }
      let(:newly_appointed_author) { destroy_author.call.value! }

      it('succeeds') { expect(destroy_author.call).to be_success }

      it 'delegates courses to one of the remaining authors' do
        expect(newly_appointed_author.course_ids).to include(*ex_author_course_ids)
      end

      it 'removes ex author from db' do
        expect { destroy_author.call }.to change(ex_author, :persisted?).from(true).to(false)
      end

      it 'does not affect new author`s own courses' do
        expect(newly_appointed_author.courses.size).to eq(3)
      end
    end

    context "when no authors left in DB" do
      it('fails') do
        expect(destroy_author.call).to be_failure
      end
    end
  end
end
