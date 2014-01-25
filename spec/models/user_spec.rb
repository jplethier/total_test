require 'spec_helper'

describe User do
  subject { user }

  let(:user) { FactoryGirl.build :user }

  its(:valid?) { should be true }

  describe 'validations' do
    describe 'email' do
      it 'is required' do
        expect { user.email = nil }.to change{ user.valid? }.from(true).to(false)
      end

      it 'contains one and only one @' do
        valid_email = user.email
        expect { user.email = 'a@a.com' }.to_not change{ user.valid? }.from(true).to(false)
        user.email = valid_email
        expect { user.email = 'a@a@com' }.to change{ user.valid? }.from(true).to(false)
        user.email = valid_email
        expect { user.email = 'a_a.com' }.to change{ user.valid? }.from(true).to(false)
      end
    end

    describe 'password' do
      it 'is required' do
        expect { user.password = nil }.to change{ user.valid? }.from(true).to(false)
      end

      it 'has to be equal to confirmation' do
        expect { user.password_confirmation = 'different' }.to change{ user.valid? }.from(true).to(false)
      end

      it 'has to have at least 6 characters' do
        expect { user.password = '12345' }.to change{ user.valid? }.from(true).to(false)
      end

      it 'has to have at maximum 128 characters' do
        expect { user.password = '1'*129 }.to change{ user.valid? }.from(true).to(false)
      end
    end
  end

  describe 'methods' do
    it 'guest?' do
      expect { user.save }.to change{ user.guest? }.from(true).to(false)
    end
  end
end
