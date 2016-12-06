require 'rails_helper'
include RandomData

RSpec.describe WikisController, type: :controller do
let(:user) { User.create!(name: "user name", email: "username@example.com", password: "helloworld") }
let(:my_wiki) { Wiki.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, private: false, user: user) }


context "logged in user doing wiki CRUD" do


  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new view" do
      get :new
      expect(response).to render_template :new
    end

    it "instantiated @wiki" do
      get :new
      expect(assigns(:wikis)).not_to be_nil
    end
  end


  describe "POST create" do
    it "increases the number of Wikis by 1" do
      expect{post :create, wikis: {title: RandomData.random_sentence, body: RandomData.random_paragraph}}.to change(Wiki,:count).by(1)
    end

    it "assigns new wiki to @wikis" do
      post :create, wikis: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(assigns(:wikis)).to eq Wiki.last
    end

    it "redirects to the new Wiki" do
      post :create, wikis: {title: RandomData.random_sentence, body: RandomData.random_paragraph}
      expect(response).to redirect_to Wiki.last
    end
  end


  describe "GET #show" do
    it "returns http success" do
      get :show
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, {id: my_wiki.id}
      expect(response).to render_template :show
    end

    it "assigns my_wiki to @wiki" do
      get :show, {id: my_wiki.id}
      expect(assigns(:wikis)).to eq(my_wiki)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit
      expect(response).to have_http_status(:success)
    end
  end
end
end
