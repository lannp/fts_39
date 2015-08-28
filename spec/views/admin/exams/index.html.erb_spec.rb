require "rails_helper"

describe "admin/exams/index" do
  before :each do 
    4.times{FactoryGirl.create :exam}
    @exams = Exam.all.paginate page: params[:page], per_page: Settings.page_size
  end

  it " request to exams controller and index action" do
    assign :exams, @exams
    render
    expect(controller.request.path_parameters[:controller]).to eq "admin/exams"
    expect(controller.request.path_parameters[:action]).to eq "index"
  end

  it "contain list of condition value for admin filter the examinations" do
    render
    expect(rendered).to include Settings.exams.start || Settings.exams.view
  end
end
