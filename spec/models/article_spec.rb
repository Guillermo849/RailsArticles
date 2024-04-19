# frozen_string_literal: true

require 'rails_helper'
require 'factories/articles'

RSpec.describe Article, type: :model do
  let(:article) { create :article }
  let(:user) { create :user }

  describe 'validations' do
    context 'presence of' do
      it do
        expect(subject).to validate_presence_of(:title)
        expect(subject).to validate_presence_of(:body)
        expect(subject).to validate_presence_of(:user_id)
      end

      it do
        expect(User.where(id: article.user_id)).to exist
      end
    end

    context 'it belongs to user' do
      it do
        expect do
          Article.create(
            title: 'Something',
            body: 'Another thing',
            user_id: article.user_id
          )
        end.to change {
                 Article.where(user_id: article.user_id).count
               }.by(1)
      end
    end
  end
end
