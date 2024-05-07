# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:article) { create :article }
  let(:user) { create :user }

  describe 'validations' do
    context 'when presence of' do
      it do
        expect(subject).to validate_presence_of(:title)
        expect(subject).to validate_presence_of(:body)
      end
    end
  end

  describe 'relation' do
    it do
      expect(subject).to belong_to(:user)
    end
  end
end
