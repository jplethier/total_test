require 'spec_helper'

describe Task do
  subject { task }

  let(:task) { FactoryGirl.build :task }

  its(:valid?) { should be true }

  describe 'validations' do
    it 'requires a name' do
      expect { task.name = nil }.to change{ task.valid? }.from(true).to(false)
    end

    it 'requires a due date' do
      expect { task.due_date = nil }.to change{ task.valid? }.from(true).to(false)
    end

    it 'requires an user' do
      expect { task.user = nil }.to change{ task.valid? }.from(true).to(false)
    end
  end

  describe 'methods' do
    it 'is_done?' do
      task.done = false
      expect { task.done = true }.to change{ task.is_done? }.from(false).to(true)
    end
  end
end
