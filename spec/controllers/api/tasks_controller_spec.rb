require 'spec_helper'

describe Api::TasksController do
  let(:user) { stub_model(User) }
  let(:task) { stub_model(Task, user: user) }
  let(:token) { double :accessible? => true }

  describe 'index' do
    context 'with token' do
      before do
        controller.stub(doorkeeper_token: token)
        controller.stub(current_resource_owner: user)
        user.stub(tasks: [task])
      end

      it 'assigns @tasks' do
        get :index, format: :json
        expect(assigns :tasks).to eq [task]
      end

      it 'response should be 200' do
        get :index, format: :json
        response.status.should == 200
      end

      it 'response should be tasks json' do
        get :index, format: :json
        response.body.should == [task].to_json
      end
    end

    context 'without token' do
      before do
        controller.stub(:doorkeeper_token) { nil }
      end

      it 'response should be 401' do
        get :index, format: :json
        response.status.should == 401
      end
    end
  end

  describe 'create' do
    let(:params) { { format: :json, task: { name: 'f_task', due_date: '2018-12-12', priority: 1 } } }

    context 'with token' do
      before do
        controller.stub(doorkeeper_token: token)
        controller.stub(current_resource_owner: user)
        Task.stub(new: task)
      end

      context 'successfully' do
        before { task.stub(save: true) }

        it 'assigns @task' do
          post :create, params
          expect(assigns :task).to eq task
        end

        it 'response should be 201' do
          post :create, params
          response.status.should == 201
        end

        it 'response should be task json' do
          post :create, params
          response.body.should == task.to_json
        end

        it 'saves the task' do
          expect(task).to receive :save
          post :create, params
        end
      end

      context 'unsuccessfully' do
        before { task.stub(save: false) }

        it 'assigns @task' do
          post :create, params
          expect(assigns :task).to eq task
        end

        it 'response should be 422' do
          post :create, params
          response.status.should == 422
        end

        it 'response should be task json' do
          post :create, params
          response.body.should == task.to_json
        end
      end
    end

    context 'without token' do
      before do
        controller.stub(:doorkeeper_token) { nil }
      end

      it 'response should be 401' do
        post :create, params
        response.status.should == 401
      end
    end
  end

  describe 'update' do
    let(:params) { { format: :json, id: 1, task: { name: 'f_task', due_date: '2018-12-12', priority: 1 } } }

    context 'with token' do
      before do
        controller.stub(doorkeeper_token: token)
        controller.stub(current_resource_owner: user)
      end

      context 'successfully' do
        before do
          user.stub_chain(:tasks, :where, :first).and_return(task)
          task.stub(update_attributes: true)
        end

        it 'assigns @task' do
          put :update, params
          expect(assigns :task).to eq task
        end

        it 'response should be 200' do
          put :update, params
          response.status.should == 200
        end

        it 'response should be task json' do
          put :update, params
          response.body.should == task.to_json
        end

        it 'updates the task' do
          expect(task).to receive :update_attributes
          put :update, params
        end
      end

      context 'unsuccessfully' do
        before do
          user.stub_chain(:tasks, :where, :first).and_return(task)
          task.stub(update_attributes: false)
        end

        it 'assigns @task' do
          put :update, params
          expect(assigns :task).to eq task
        end

        it 'response should be 422' do
          put :update, params
          response.status.should == 422
        end

        it 'response should be task json' do
          put :update, params
          response.body.should == task.to_json
        end
      end

      context 'task from another user' do
        before { user.stub_chain(:tasks, :where, :first).and_return(nil) }

        it 'response should be 403' do
          put :update, params
          response.status.should == 403
        end

        it 'does not update the task' do
          expect(task).to_not receive :update_attributes
          delete :destroy, params
        end
      end
    end

    context 'without token' do
      before do
        controller.stub(:doorkeeper_token) { nil }
      end

      it 'response should be 401' do
        post :create, params
        response.status.should == 401
      end
    end
  end

  describe 'destroy' do
    let(:params) { { format: :json, id: 1 } }

    context 'with token' do
      before do
        controller.stub(doorkeeper_token: token)
        controller.stub(current_resource_owner: user)
        task.stub(destroy: task)
      end

      context 'own task' do
        before { user.stub_chain(:tasks, :where, :first).and_return(task) }

        it 'assigns @task' do
          delete :destroy, params
          expect(assigns :task).to eq task
        end

        it 'response should be 200' do
          delete :destroy, params
          response.status.should == 200
        end

        it 'response should be task json' do
          delete :destroy, params
          response.body.should == task.to_json
        end

        it 'destroys the task' do
          expect(task).to receive :destroy
          delete :destroy, params
        end
      end

      context 'task from another user' do
        before { user.stub_chain(:tasks, :where, :first).and_return(nil) }

        it 'response should be 403' do
          delete :destroy, params
          response.status.should == 403
        end

        it 'does not destroy the task' do
          expect(task).to_not receive :destroy
          delete :destroy, params
        end
      end
    end

    context 'without token' do
      before do
        controller.stub(:doorkeeper_token) { nil }
      end

      it 'response should be 401' do
        delete :destroy, params
        response.status.should == 401
      end
    end
  end

  describe 'done' do
    let(:params) { { format: :json, id: 1 } }

    context 'with token' do
      before do
        controller.stub(doorkeeper_token: token)
        controller.stub(current_resource_owner: user)
        task.stub(done!: task)
      end

      context 'own task' do
        before { user.stub_chain(:tasks, :where, :first).and_return(task) }

        it 'assigns @task' do
          post :done, params
          expect(assigns :task).to eq task
        end

        it 'response should be 200' do
          post :done, params
          response.status.should == 200
        end

        it 'response should be task json' do
          post :done, params
          response.body.should == task.to_json
        end

        it 'completes the task' do
          expect(task).to receive :done!
          post :done, params
        end
      end

      context 'task from another user' do
        before { user.stub_chain(:tasks, :where, :first).and_return(nil) }

        it 'response should be 403' do
          post :done, params
          response.status.should == 403
        end

        it 'does not complete the task' do
          expect(task).to_not receive :done!
          post :done, params
        end
      end
    end

    context 'without token' do
      before do
        controller.stub(:doorkeeper_token) { nil }
      end

      it 'response should be 401' do
        post :done, params
        response.status.should == 401
      end
    end
  end

  describe 'undone' do
    let(:params) { { format: :json, id: 1 } }

    context 'with token' do
      before do
        controller.stub(doorkeeper_token: token)
        controller.stub(current_resource_owner: user)
        task.stub(undone!: task)
      end

      context 'own task' do
        before { user.stub_chain(:tasks, :where, :first).and_return(task) }

        it 'assigns @task' do
          post :undone, params
          expect(assigns :task).to eq task
        end

        it 'response should be 200' do
          post :undone, params
          response.status.should == 200
        end

        it 'response should be task json' do
          post :undone, params
          response.body.should == task.to_json
        end

        it 'opens the task' do
          expect(task).to receive :undone!
          post :undone, params
        end
      end

      context 'task from another user' do
        before { user.stub_chain(:tasks, :where, :first).and_return(nil) }

        it 'response should be 403' do
          post :undone, params
          response.status.should == 403
        end

        it 'does not open the task' do
          expect(task).to_not receive :undone!
          post :undone, params
        end
      end
    end

    context 'without token' do
      before do
        controller.stub(:doorkeeper_token) { nil }
      end

      it 'response should be 401' do
        post :undone, params
        response.status.should == 401
      end
    end
  end
end
