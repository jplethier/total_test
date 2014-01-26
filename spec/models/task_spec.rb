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

    describe 'order_by' do
      let!(:task)  { FactoryGirl.create :task, name: 'AB', priority: 1, due_date: '2014-12-12' }
      let!(:task2) { FactoryGirl.create :task, name: 'AC', priority: 2, due_date: '2015-12-12' }
      let!(:task3) { FactoryGirl.create :task, name: 'BC', priority: 3, due_date: '2015-11-12' }

      it 'by default is ordered by due_date' do
        Task.order_by(nil).all.should == [task, task3, task2]
      end

      it 'by due_date' do
        Task.order_by('due_date').all.should == [task, task3, task2]
      end

      it 'by priority' do
        Task.order_by('priority').all.should == [task, task2, task3]
      end

      it 'by name' do
        Task.order_by('name').all.should == [task, task2, task3]
      end
    end

    it 'done!' do
      task.done = false
      expect { task.done! }.to change{ task.done }.from(false).to(true)
    end

    it 'undone!' do
      task.done = true
      expect { task.undone! }.to change{ task.done }.from(true).to(false)
    end
  end
end
