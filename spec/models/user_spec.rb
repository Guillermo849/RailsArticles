# frozen_string_literal: true

require 'rails_helper'
require 'factories/users'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  describe 'validations' do
    context 'when presence of' do
      it do
        expect(subject).to validate_presence_of(:first_name)
        expect(subject).to validate_presence_of(:surname)
        expect(subject).to validate_inclusion_of(:age).in_range(1..120)
      end
    end
  end
end
