# == Schema Information
#
# Table name: users
#
#  id              :bigint(8)        not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe User, type: :model do 
  describe "validations" do 
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password_digest) }
    it {should validate_length_of(:password).is_at_least(6)}
  end

  describe "uniqueness" do
    before :each do 
      create(:user)
    end
    it { should validate_uniqueness_of(:username)}
  end

  describe "ensure_session_token" do 
    before :each do 
        create(:user)
      end
    it "should create a session token after initialization" do      
      expect(User.last.session_token).to_not be(nil)
    end
  end

  describe "class methods" do 
    describe "::find_by_credentials" do 
      before :each do 
        create(:user)
      end

      it "should return nil if invalid infornation is given" do 
        expect(User.find_by_credentials("John Doe", "passwort")).to be(nil)
        expect(User.find_by_credentials("Jane Doe", "password")).to be(nil)
      end

      it "should return user if valid infornation is given" do 
        expect(User.find_by_credentials("John Doe", "password")).to eq(User.last)
      end
    end
  end

end
