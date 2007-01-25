class User < ActiveRecord::Base
  has_many :movie_items
  has_many :movies, :through => :movie_items
  has_many :requests
  
  validates_presence_of     :email, :password, :first_name, :last_name
  validates_uniqueness_of   :email
  
  validates_confirmation_of :password, :email
  
  attr_accessor :password
  attr_accessible  :first_name, :last_name, :email, :email_confirmation, :password, :password_confirmation
  
  def full_name
    first_name + " " + last_name
  end
  
  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user
      expected_password = encrypted_password(password, user.salt)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user
  end
  
  
  # 'password' is a virtual attribute
  
  def password
    @password
  end
  
  def password=(pwd)
    @password = pwd
    create_new_salt
    self.hashed_password = User.encrypted_password(self.password, self.salt)
  end
  
  
  private
  
  
  def create_new_salt
    self.salt = self.object_id.to_s + rand.to_s
  end
  
  
  
  def self.encrypted_password(password, salt)
    string_to_hash = password + "pepper" + salt
    Digest::SHA1.hexdigest(string_to_hash)
  end
  
end
