require 'spec_helper'
require "cancan/matchers"

describe Ability do
  context 'Guest user' do
    let(:user)    { FactoryGirl.build :user }
    let(:ability) { Ability.new(user) }

    it 'can not manage tasks' do
      task = FactoryGirl.create :task
      expect(ability).to_not be_able_to :manage, task
    end
  end

  context 'Registered user' do
    let(:user)    { FactoryGirl.create :user }
    let(:ability) { Ability.new(user) }

    it 'can manage his tasks' do
      user_task = FactoryGirl.create :task, user: user
      another_task = FactoryGirl.create :task
      expect(ability).to be_able_to :manage, user_task
      expect(ability).to_not be_able_to :manage, another_task
    end
  end
end
