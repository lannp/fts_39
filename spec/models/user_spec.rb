require "rails_helper"
require "cancan/matchers"

describe "User" do
  describe "create" do
    context "valid user" do
      let(:user){FactoryGirl.create :user}
      it{expect(user.errors).to be_empty}
    end

    context "invalid password" do
      let(:user){User.create FactoryGirl.attributes_for :invalid_password}
      it{expect(user.errors[:password]).to be_present}
    end
    
    context "invalid email" do
      let(:user){User.create FactoryGirl.attributes_for :invalid_email}
      it{expect(user.errors[:email]).to be_present}
    end
  end

  describe "has abilities" do
    context "admin account" do
      let(:user){FactoryGirl.create :admin}
      subject(:ability){Ability.new(user)}
      it{is_expected.to be_able_to :manage, Category}
      it{is_expected.to be_able_to :manage, Question}
      it{is_expected.to be_able_to :manage, User}
      it{is_expected.to be_able_to :manage, Exam}
    end

    context "normal account" do
      let(:user){FactoryGirl.create :user}
      subject(:ability){Ability.new(user)}
      it{is_expected.not_to be_able_to :manage, Category.new}
      it{is_expected.not_to be_able_to :manage, Question}
      it{is_expected.not_to be_able_to :manage, User}
      it{is_expected.not_to be_able_to :manage, Exam}
    end
  end

  describe "has 1 exam" do
    let!(:user){FactoryGirl.create :user}
    let(:user_exams){nil}
    before{
      FactoryGirl.create :user
      user.exams.create FactoryGirl.attributes_for :exam
    }
    it{expect(user.exams.count).to eq 1}
    context "when deleting the user" do
      before{user.destroy}
      it{expect(user.exams.count).to eq 0}
    end
  end
end
