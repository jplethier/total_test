class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks
  accepts_nested_attributes_for :tasks, allow_destroy: true

  def guest?
    self.new_record?
  end
end
