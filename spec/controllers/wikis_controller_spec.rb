require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:user) { User.create!(name: "user name", email: "username@example.com", password: "helloworld", confirmed_at: Time.now) }
  let(:my_wiki) { Wiki.create!(title: Faker::Hipster.sentence , body: Faker::Hipster.paragraph , private: false, user: user) }

  # :each runs before "it" tests
  before :each do
    sign_in user
  end

  # guest user and what they can do
  context "guest user" do

    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
        #expect(response).to render_template :show ?????

      end
    end
  end


  context "logged in user doing wiki CRUD" do

    # wiki index page
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    # creating a new wiki
    describe "GET #new" do
      it "returns http success" do
        get :new
        expect(response).to have_http_status(:success)
      end

      it "renders the new view" do
        get :new
        expect(response).to render_template :new
      end
      # new wiki is created`
      it "instantiated @wikis" do
        get :new
        expect(assigns(:wiki)).not_to be_nil
      end
    end

    # POST create. Make sure a new instance of wiki is created with a title and body
    describe "POST create" do
      it "increases the number of Wikis by 1" do
        expect{post :create, wiki: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph}}.to change(Wiki,:count).by(1)
      end

      it "assigns new wiki to @wikis" do
        post :create, wiki: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph}
        expect(assigns(:wiki)).to eq Wiki.last
      end

      # redirect to new wiki when new wiki is created
      it "redirects to the new Wiki" do
        post :create, wiki: {title: Faker::Hipster.sentence, body: Faker::Hipster.paragraph}
        expect(response).to redirect_to Wiki.last
      end
    end


    describe "GET #show" do
      it "returns http success" do
        get :show, id: my_wiki.id
        expect(response).to have_http_status(:success)
      end

      it "renders the #show view" do
        get :show, {id: my_wiki.id}
        expect(response).to render_template :show
      end

      it "assigns my_wiki to @wiki" do
        get :show, {id: my_wiki.id}
        expect(assigns(:wiki)).to eq(my_wiki)
      end
    end

    describe "GET #edit" do
      it "returns http success" do
        get :edit, {id: my_wiki.id}
        expect(response).to have_http_status(:success)
      end

      it "renders the #edit view" do
        get :edit, {id: my_wiki.id}
        expect(response).to render_template :edit
      end
      # assigns correct wiki to be updated to @wikis
      it "assigns wiki to be updated to @wikis" do
        get :edit, {id: my_wiki.id}
        wiki_instance = assigns(:wiki)

        expect(wiki_instance.id).to eq my_wiki.id
        expect(wiki_instance.title).to eq my_wiki.title
        expect(wiki_instance.body).to eq my_wiki.body
      end
    end

    describe "PUT update" do
      it "updates wiki with expected attributes" do
        new_title = Faker::Hipster.sentence
        new_body = Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki:{title: new_title, body: new_body}

        updated_wiki = assigns(:wiki)
        expect(updated_wiki.id).to eq my_wiki.id
        expect(updated_wiki.title).to eq new_title
        expect(updated_wiki.body).to eq new_body
      end

      it "redirects to the updated wiki" do
        new_title = Faker::Hipster.sentence
        new_body =Faker::Hipster.paragraph

        put :update, id: my_wiki.id, wiki: {title: new_title, body: new_body}
        expect(response).to redirect_to my_wiki
      end
    end

    describe "DELETE destroy" do
      it "deletes the wiki" do
        delete :destroy, {id: my_wiki.id}
        count = Wiki.where({id: my_wiki.id}).size
        expect(count).to eq 0
      end

      it "redirects to wiki index" do
        delete :destroy, {id: my_wiki.id}
        expect(response).to redirect_to wikis_path
      end
    end
  end
end
