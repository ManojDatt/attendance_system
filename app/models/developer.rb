class Developer < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :authentication_keys=>[:login]
  
  attr_accessor :login
  has_many :attendances,dependent: :destroy
  has_many :todos, dependent: :destroy
  has_many :notifications, dependent: :destroy
  has_one :leave, dependent: :destroy
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
    username
  end 

  

  def create_leave_record
    if Time.current.mday <=15
      self.create_leave(:total_leave=> 1,:available_leave=> 1)
      Developer.create_attendance(self)
    else
      self.create_leave(:total_leave=> 0,:available_leave=> 0)
      Developer.create_attendance(self)
    end
  end

  ###==========   Add leave on every month's 1 st day
  def self.add_leave
    developers = Developer.all
    developers.each do |developer|
      if (Date.current.month - developer.created_at.month) >= 4
        updated_total_leave = developer.leave.total_leave + 1.5
        developer.leave.update(total_leave:updated_total_leave)
      else
         updated_total_leave = developer.leave.total_leave + 1
        developer.leave.update(total_leave:updated_total_leave)
      end  
    end
  end

  def self.create_attendance(developer)
    sunday = []
    saturday = []
    all_days = (DateTime.current..DateTime.current.end_of_month).to_a
    all_days.each_with_index{|v,i| sunday.append(i) if v.wday==0}
    all_days.each_with_index{|v,i| saturday.append(i) if v.wday==6}
    all_days.each_with_index do |day, index|
      day = day + 5.5.hours
      if index == saturday[1] || index == saturday[3] || sunday.include?(index)
        developer.attendances.create(week_off: true, created_at:day, updated_at:day)
      elsif index == saturday[0] || index == saturday[2] || index == saturday[4]
        developer.attendances.create(punch_in_at: 9.5, punch_out_at: 16,  created_at:day, updated_at:day)
      else
        developer.attendances.create( created_at:day, updated_at:day)
      end
    end
  end


  def to_csv(attendance_data)
      attributes = %w{punch_in_time punch_out_time extra_work work_hour lat_in early_out week_off punch_in_at punch_out_at punch_in_status first_half second_half}

       CSV.generate(headers: true) do |csv|
         # header row
         csv << attributes
         # add a row for each attendance
         attendance_data.each do |attendance|
           csv << attendance.attributes.values_at(*attributes)
         end
      end

  end

  def active_for_authentication?
      super && (self.is_locked ? false : true) 
  end

  def inactive_message
    "Sorry, your account has been locked. Please contact to admin."
  end

  private

  def password_required?
    new_record? ? super : false
  end



  
end
