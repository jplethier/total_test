class Task < ActiveRecord::Base
  belongs_to :user

  validates :due_date, presence: true
  validates :name,     presence: true
  validates :user_id,  presence: true
end
