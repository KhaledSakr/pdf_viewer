class User < ActiveRecord::Base

  attr_accessor :remember_token

  # FB Authorization to login with Facebook
  has_many :authorizations
  has_many :uploads
  has_many :comments

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  # Requirments for validation
  validates :name,  presence: true,
                    length: { maximum: 50 }
                    
  validates :email, presence: true, 
                    length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  before_save { self.email = email.downcase }
  
  validates :password, presence: true,
                       length: { minimum: 6 }
  
  # Allows rails to store a password digest using bcrypt                     
  has_secure_password

  # Returns a token used in session cookies
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def square_image
    "http://graph.facebook.com/#{self.authorizations.first.uid}/picture?type=square"
  end

  def normal_image
    "http://graph.facebook.com/#{self.authorizations.first.uid}/picture?type=normal"
  end

  def large_image
    "http://graph.facebook.com/#{self.authorizations.first.uid}/picture?type=large"
  end

  def avatar
    if self.authorizations.first
      return normal_image
    else
      robo_hash = Digest::MD5.hexdigest(self.email.downcase)
      return "https://robohash.org/#{robo_hash}.png"
    end
  end
  
end
