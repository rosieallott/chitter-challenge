require_relative '../data_mapper_setup'
require 'bcrypt'
require 'dm-validations'
require_relative 'peep'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :format => :email_address
  property :name, String
  property :username, String, :unique => true
  property :password, BCryptHash
  has n, :peeps, through: Resource

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  def self.authenticate(email, password)
    user = first(email: email)
    if user && BCrypt::Password.new(user.password) == password
      user
    else
      false
    end
  end

end
