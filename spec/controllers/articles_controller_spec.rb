# frozen_string_literal: true

require 'rails_helper'
require 'factories/articles'

RSpec.describe ArticlesController, type: :controller do
  let(:article) { create :article }

  describe '[GET] #index' do
    before { get :index }

    it do
      expect(assigns(:articles)).to eq([article])
      expect(response).to render_template('index')
    end
  end

  describe '[GET] #show' do
    context 'when article was found' do
      before { get :show, params: { id: article.id } }

      it do
        expect(assigns(:article)).to eq(article)
        expect(response).to render_template('show')
      end
    end

    context 'article was not found' do
      before { get :show, params: { id: 10_000 } }

      it do
        expect(response).to redirect_to(articles_path)
        expect(flash: [:danger])
      end
    end
  end

  describe '[GET] #new' do
    before { get :new }

    it 'renders new article template' do
      expect(response).to render_template('new')
    end
  end

  describe '[POST] #create' do
    let(:user) { create :user }

    context 'with valid attributes' do
      it do
        post :create, params: { article: { title: article.title, body: article.body, user_id: user } }
        expect(flash: [:success])
        get :show, params: { id: article.id }
        expect(response).to render_template('show')
      end
    end

    context 'with invalid attributes' do
      it do
        post :create, params: { article: { title: article.title, body: article.body, user_id: nil } }
        expect(flash: [:danger])
        expect(response).to render_template('new')
      end
    end
  end

  describe '[GET] #edit' do
    it 'render edit template' do
      get :edit, params: { id: article.id }
      expect(response).to render_template('edit')
    end
  end

  describe '[PUT] #update' do
    let(:user) { create :user }

    context 'valid attributes' do
      it do
        put :update,
            params: { id: article.id,
                      article: { title: 'Very important info', body: 'Something something', user_id: user } }
        expect(flash: [:success])
        get :show, params: { id: article.id }
        expect(response).to render_template('show')
      end
    end

    context 'invalid attributes' do
      it do
        put :update,
            params: { id: article.id,
                      article: { title: 'Very important info', body: 'Something something', user_id: nil } }
        expect(flash: [:danger])
        expect(response).to render_template('edit')
      end
    end
  end

  describe '[DELETE] #destroy' do
    context 'delete an existing article' do
      it do
        delete :destroy, params: { id: article.id }
        expect(flash: [:success])
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'delete a non-existent article' do
      it do
        delete :destroy, params: { id: 10_000 }
        expect(flash[:danger]).to include('Article not found')
      end
    end
  end
end
