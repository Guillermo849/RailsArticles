require 'rails_helper'
require 'factories/articles'

RSpec.describe Article, type: :model do
  let(:article) { FactoryBot.build(:article) }

  context 'Should validate' do
    it 'with title, body and user present' do
      expect(article).to be_valid
    end
  end

  context 'Should not be valid' do
    it 'when title is not present' do
      article.title = nil
      expect(article).not_to be_valid
    end

    it 'when body is not present' do
      article.body = nil
      expect(article).not_to be_valid
    end

    it 'when user_id is not present' do
      article.user = nil
      expect(article).not_to be_valid
    end
  end
end
