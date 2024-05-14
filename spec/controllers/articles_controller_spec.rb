# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  let!(:article) { create :article }
  let(:user) { create :user }

  describe '[GET] #index' do
    before do
      sign_in user
      get :index, params: { user_id: user.id }
    end

    it do
      expect(assigns(:articles)).to eq([article])
      expect(response).to render_template('index')
    end
  end

  describe '[GET] #show' do
    before { sign_in user }
    context 'when article was found' do
      before { get :show, params: { user_id: user.id, id: article.id } }

      it do
        expect(assigns(:article)).to eq(article)
        expect(response).to render_template('show')
      end
    end

    context 'when article was not found' do
      before { get :show, params: { user_id: user.id, id: 'invalid' } }

      it do
        expect(response).to redirect_to(user_articles_path)
        expect(flash[:danger]).to eq('Article not found')
      end
    end
  end

  describe '[GET] #new' do
    before do
      sign_in user
      get :new, params: { user_id: user.id }
    end

    it do
      expect(response).to render_template('new')
    end
  end

  describe '[POST] #create' do
    before { sign_in user }
    let(:params) do
      { user_id: user.id, article: { title: article.title, body: article.body, user_id: user.id } }
    end

    context 'when article was created' do
      before { post :create, params: params }

      it do
        expect(Article.find_by(params[:article])).not_to be_nil
        expect(flash[:success]).to eq('New article successfully created')
      end
    end

    context 'when article was not created' do
      before do
        params[:article][:user_id] = nil
        post :create, params: params
      end

      it do
        expect(flash[:danger]).to eq('Article creation failed')
        expect(response).to render_template('new')
      end
    end
  end

  describe '[GET] #edit' do
    before { sign_in user }
    context 'when article found' do
      before { get :edit, params: { user_id: user.id, id: article.id } }

      it do
        expect(response).to render_template('edit')
        expect(assigns(:article)).to eq(article)
      end
    end

    context 'when article found' do
      before { get :edit, params: { user_id: user.id, id: 'invalid' } }

      it do
        expect(flash[:danger]).to include('Article not found')
      end
    end
  end

  describe '[PUT] #update' do
    before { sign_in user }
    context 'when params are valid' do
      before { put :update, params: { user_id: user.id, id: article.id, article: { user_id: user.id } } }

      it do
        expect(flash[:success]).to include('Article successfully updated')
        expect(article.reload.user_id).to eq(user.id)
      end
    end

    context 'when params are not valid' do
      before { put :update, params: { user_id: user.id, id: article.id, article: { user_id: nil } } }

      it do
        expect(flash[:danger]).to include('Article update failed')
      end
    end
  end

  describe '[DELETE] #destroy' do
    before { sign_in user }
    context 'delete an existing article' do
      before { delete :destroy, params: { user_id: user.id, id: article.id } }

      it do
        expect(flash[:success]).to include('Article successfully deleted')
        expect(Article.find_by(id: article.id)).to eq(nil)
      end
    end

    context 'delete a non-existent article' do
      before { delete :destroy, params: { user_id: user.id, id: 'invalid' } }

      it do
        expect(flash[:danger]).to include('Article not found')
      end
    end
  end
end
