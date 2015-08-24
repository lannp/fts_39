require "rails_helper"

describe Admin::CategoriesController do
  let(:admin){FactoryGirl.create(:admin)}
  let(:category){FactoryGirl.create(:category)}
  before{sign_in admin}

  describe "GET index" do
    before{get :index}
    it{expect(response).to be_success} 
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :index}
  end

  describe "GET show" do
    before{get :show, id: category}
    it{expect(response).to be_success} 
    it{expect(response).to have_http_status 200}
    it{expect(response).to render_template :show}
  end

  describe "POST create" do
    context "valid attributes" do
      before{post :create, category: FactoryGirl.attributes_for(:category)}
      it{expect(response).to redirect_to admin_categories_path}
      it{expect(flash[:success]).to be_present}
    end
    context "invalid attributes" do
      before{post :create, category: FactoryGirl.attributes_for(:invalid_category)}
      it{expect(response).to redirect_to admin_categories_path}
      it{expect(flash[:danger]).to be_present}
    end
  end

  describe "PATCH update" do
    context "valid attributes" do
      before do
        patch :update, id: category.id, category: FactoryGirl.attributes_for(:category)
      end
      it{expect(flash[:success]).to be_present} 
      it{response.should redirect_to admin_categories_path}
    end
    context "invalid attributes" do
      before do 
        patch :update,id: category.id,
        category: FactoryGirl.attributes_for(:invalid_category)
      end 
      it{expect(response).to render_template :edit}
      it{expect(flash[:danger]).to be_present} 
    end
  end
  describe "DELETE destroy" do
    before{delete :destroy, id: category.id}
    it{expect(response).to redirect_to admin_categories_path}
    it{expect(flash[:success]).not_to be_nil}
  end
end
