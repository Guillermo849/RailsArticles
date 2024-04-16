require 'rails_helper'
require 'factories/users'

RSpec.describe User, type: :model do
  let(:user) { FactoryBot.build(:user) }

  context 'Should validate' do
    it 'with first_name, surname and age present' do
      expect(user).to be_valid
    end
  end

  context 'Should not be valid' do
    it 'when first_name is not present' do
      user.first_name = nil
      expect(user).not_to be_valid
    end

    it 'when surname is not present' do
      user.surname = nil
      expect(user).not_to be_valid
    end

    it 'when age is not present' do
      user.age = nil
      expect(user).not_to be_valid
    end

    it 'when age is not numeric' do
      user.age = 'words'
      expect(user).not_to be_valid
    end

    it 'when age is not numeric integer' do
      user.age = 34.5
      expect(user).not_to be_valid
    end
  end
end
