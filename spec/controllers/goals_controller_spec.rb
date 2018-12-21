require 'rails_helper'

RSpec.describe UsersController, type: :controller do 
  
  describe "GET #show" do 
    before :each do 
      create(:goal)
    end
    let!(:goal) { Goal.last }

    context "with an existing goal" do 
      it "should render the show page" do 
        get :show, params: {id: goal.id}  
        expect(response).to render_template(:show) 
      end
    end

    context "without an existing user" do 
      before :each do 
        get :show, params: {id: goal.id+1}  
      end
      it "should redirect to users page" do 
        expect(response).to redirect_to(user_url((goal.user)))
      end
      it 'should add a flash' do 
        expect(flash[:errors]).to be_present
      end
    end
  end

end