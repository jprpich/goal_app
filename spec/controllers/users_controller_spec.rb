require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
  describe "GET #index" do 
    it "should render our index page" do 
      get :index 
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do 
    before :each do 
      create(:user)
    end
    let!(:user) { User.last }

    context "with an existing user" do 
      it "should render the show page" do 
        get :show, params: {id: user.id}  
        expect(response).to render_template(:show) 
      end
    end

    context "without an existing user" do 
      before :each do 
        get :show, params: {id: user.id+1}  
      end
      it "should redirect to index page" do 
        expect(response).to redirect_to(users_url)
      end
      it 'should add a flash' do 
        expect(flash[:errors]).to be_present
      end
    end
  end


  describe "GET #new" do 
    it "should render our new page" do 
      get :new 
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do 
    context "with valid params" do 
      let!(:valid_params) { {user: {username: 'Joshua', password: 'password'}}}
      it "should save user to the database" do 
        post :create, params: valid_params
        expect(User.last.username).to eq('Joshua')
      end

      it "should redirect to user show page" do 
        post :create, params: valid_params
        expect(response).to redirect_to(user_url(User.last)) 
      end
    end      

    context "with invalid params" do 
      let!(:invalid_params) { {user: {username: 'Joshua', password: 'pd'}}}
      it "should not save user to the database" do 
        post :create, params: invalid_params
        expect(User.last).to be(nil)
      end

      it "should redirect to user show page" do 
        post :create, params: invalid_params
        expect(response).to render_template(:new) 
      end

       it "should flash error" do 
        post :create, params: invalid_params
        expect(flash[:errors]).to be_present
      end
    end  


  end

end