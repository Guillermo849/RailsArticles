# frozen_string_literal: true

require 'rails_helper'
require 'factories/users'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'validations' do
    context 'presence of' do
      it do
        expect(subject).to validate_presence_of(:first_name)
        expect(subject).to validate_presence_of(:surname)
        expect(subject).to validate_presence_of(:age)
      end

      it do
        expect(user.age).to be_a_kind_of(Integer)
      end
    end
  end
end
