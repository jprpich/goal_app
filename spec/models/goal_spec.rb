# == Schema Information
#
# Table name: goals
#
#  id          :bigint(8)        not null, primary key
#  message     :string           not null
#  user_id     :integer          not null
#  public_goal :boolean          default(TRUE), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Goal, type: :model do 
  describe "validations" do 
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:user_id) }
  end

end
