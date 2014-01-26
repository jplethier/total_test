require 'spec_helper'

describe TasksController do
  let(:user) { stub_model(User) }
  let(:task) { stub_model(Task, user: user) }

  before { sign_in user }

  describe 'index' do
    before do
      Task.stub(accessible_by: [task])
    end

    it 'assigns all user tasks' do
      get :index
      expect(assigns :tasks).to eq [task]
    end

    it 'assigns a new user task' do
      user.stub_chain(:tasks, :build).and_return(task)
      get :index
      expect(assigns :new_task).to eq task
    end
  end

  describe 'create' do
    let(:params)  { { task: { name: 'f_task', due_date: '2017-12-31', priority: 1 } } }

    before do
      Task.stub(new: task)
    end

    context 'successfully' do
      before { task.stub(save: true) }

      it 'renders task_created' do
        xhr :post, :create, params
        expect(response).to render_template :task_created
      end

      it 'saves the task' do
        expect(task).to receive :save
        xhr :post, :create, params
      end
    end

    context 'unsuccessfully' do
      before { task.stub(save: false) }

      it 'renders task_error' do
        xhr :post, :create, params
        expect(response).to render_template :task_error
      end
    end
  end

  describe 'destroy' do

    before do
      Task.stub(find: task)
      task.stub(destroy: task)
    end

    it 'renders destroy' do
      xhr :delete, :destroy, { id: 1 }
      expect(response).to render_template :destroy
    end

    it 'destroys the task' do
      expect(task).to receive :destroy
      xhr :delete, :destroy, { id: 1 }
    end
  end
end
