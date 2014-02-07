class Task < ActiveRecord::Base
  belongs_to :user

  validates :due_date, presence: true
  validates :name,     presence: true
  validates :user_id,  presence: true

  def is_done?
    self.done
  end

  def self.order_by(field)
    case field
    when 'name'
      order('name')
    when 'priority'
      order('priority DESC')
    else
      order('due_date')
    end
  end

  def done!
    self.done = true
    self.save
  end

  def undone!
    self.done = false
    self.save
  end
end
