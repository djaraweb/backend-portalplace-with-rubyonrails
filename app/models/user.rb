class User < ApplicationRecord
  #has_many :posts
  has_many :propertys
  
  validates :email, presence: true
  validates :name, presence: true
  validates :password, presence: true
  validates :auth_token, presence: true

  after_initialize :generate_auth_token
  before_validation :encrypted_password

  def generate_auth_token
    # User.new
    # if !auth_token.present?
    unless auth_token.present?
      #generate token
      self.auth_token = TokenGenerationService.generate
    end
  end

  def encrypted_password
    # User.new
    if password.present?
      #generate token
      self.password = Digest::MD5.hexdigest(self.password)      
    end
    
  end  
end
