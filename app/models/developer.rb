class Developer < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :authentication_keys=>[:login]
  
  attr_accessor :login
  has_many :attendances,dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :leave,dependent: :destroy
  has_many :apply_leaves,class_name:"ApplyLeave",dependent: :destroy

  after_create :create_leave_record 

  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_hash).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_hash).first
    end
  end 

  def name
    email
  end 

  def create_leave_record
    self.create_leave(:total_leave=> 1.5,:available_leave=> 1.5)    
  end


end
