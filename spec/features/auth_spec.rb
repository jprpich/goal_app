require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do 
  before :each do 
    visit new_user_url
  end
  scenario 'has a new user page' do 
    expect(page).to have_content("User Signup")
  end

  feature 'signing up a user' do
    scenario 'with valid information'  do 
      sign_up_user('Joshua', 'password')
      expect(page).to have_content('Welcome Joshua')
    end

    scenario 'with invalid information'  do 
      sign_up_user('Joshua', 'pass')
      expect(page).to have_content('invalid information')
    end
  end
end

feature 'logging in' do
  before :each do 
    create(:user)
    visit new_session_url
  end
  scenario 'has a log in page' do 
    expect(page).to have_content("Log In")
  end

  feature 'signing in a user' do
    scenario 'with valid information'  do 
      sign_in_user('Joshua', 'password')
      expect(page).to have_content('Welcome Joshua')
    end

    scenario 'with invalid information'  do 
      sign_in_user('Joshua', 'pass')
      expect(page).to have_content('invalid information')
    end
  end
end

feature 'logging out' do
  before :each do 
    create(:user)
    visit new_session_url 
    sign_in_user(User.last.username, 'password')
  end 
  scenario 'begins with a logged in state' do 
    expect(page).to have_content("Joshua")
    expect(page).to have_content("Sign Out")
  end

  scenario 'doesn\'t show username on the homepage after logout' do 
    log_out_user
    expect(page).to_not have_content("Joshua")
  end

end