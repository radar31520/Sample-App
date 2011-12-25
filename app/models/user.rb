# == Schema Information
#
# Table name: users
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  email              :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  encrypted_password :string(255)
#

class User < ActiveRecord::Base

  attr_accessor   :password
  attr_accessible :name, :email, :password, :password_confirmation

  validates :name, :presence =>  true,
                   :length => {:maximum => 50}

  validates :email, :presence => true,
                    :uniqueness => { :case_sensitive => false },
                    :format => {:with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/i }

  validates :password, :presence => true,
                       :confirmation => true,
                       :length => {:within => 6..40}

  before_save :encrypt_password


  def has_password?(submitted_password)
    self.encrypted_password == encrypt(submitted_password)
  end

  private

    def encrypt_password
      self.encrypted_password = encrypt(self.password)
    end

    def encrypt(string)
      secure_hash("#{self.salt}|-|#{string}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

end

