require "spec_helper"

describe Category do
  describe "create" do
    context "valid category" do
      subject {FactoryGirl.create :category}
      it {is_expected.to be_valid}
    end
    context "invalid category" do
      let(:category){Category.create FactoryGirl.attributes_for :invalid_category1}
      it {is_expected.not_to be_valid}
    end
  end

  describe "validation" do
    it {should ensure_length_of(:name).is_at_most(Settings.maximum_category_name_length)}
    it {should validate_presence_of(:name)}
    it {should validate_uniqueness_of(:name)}
  end

  describe "association" do
    it {should have_many(:exams)}
    it {should have_many(:questions)}
  end

  describe "#questions" do
    before {subject.questions << FactoryGirl.create(:question, category: subject)}
    it {expect{subject.destroy}.to change{Question.count}.by -1}
  end
end
