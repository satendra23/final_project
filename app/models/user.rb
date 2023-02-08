class User < ApplicationRecord
  has_secure_password
  has_many :articles
  # mount_uploader :avatar, AvatarUploader
  validates :email, presence: true, uniqueness: true
 # validates :email, format: { with: URI::MailTo::EMAIL_REGEXP}

# validates :password,            
            # if: -> { new_record? || !password.nil? }
end
