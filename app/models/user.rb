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

class User < ApplicationRecord
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6}, allow_nil: true
  validates :username, uniqueness: true 
  after_initialize :ensure_session_token 
  attr_reader :password

  has_many :goals,
    foreign_key: :user_id,
    class_name: :Goal

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def ensure_session_token 
    self.session_token ||= SecureRandom.urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64(16)
    self.save
    self.session_token
  end

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return user if user && user.is_password?(password) 
    nil
  end

  def is_password?(password)
    bpassword = BCrypt::Password.new(self.password_digest)
    bpassword.is_password?(password)
  end
end
