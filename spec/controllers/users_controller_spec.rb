# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }

  describe '[GET] #index' do
    before { get :index }

    it do
      expect(assigns(:users)).to eq([user])
      expect(response).to render_template('index')
    end
  end

  describe '[GET] #show' do
    context 'when user was found' do
      before { get :show, params: { id: user.id } }

      it do
        expect(assigns(:user)).to eq(user)
        expect(response).to render_template('show')
      end
    end

    context 'user was not found' do
      before { get :show, params: { id: 10_000 } }

      it do
        expect(response).to redirect_to(users_path)
        expect(flash: [:danger])
      end
    end
  end

  describe '[GET] #new' do
    before { get :new }

    it 'renders new user template' do
      expect(response).to render_template('new')
    end
  end

  describe '[POST] #create' do
    context 'with valid attributes' do
      it do
        post :create, params: { user: { first_name: user.first_name, surname: user.surname, age: user.age } }
        expect(flash: [:success])
        get :show, params: { id: user.id }
        expect(response).to render_template('show')
      end
    end

    context 'with invalid attributes' do
      it do
        post :create, params: { user: { first_name: nil, surname: user.surname, age: user.age } }
        expect(flash: [:danger])
        expect(response).to render_template('new')
      end
    end
  end

  describe '[GET] #edit' do
    it 'render edit template' do
      get :edit, params: { id: user.id }
      expect(response).to render_template('edit')
    end
  end

  describe '[PUT] #update' do
    context 'valid attributes' do
      it do
        put :update, params: { id: user.id, user: { first_name: 'NewFirstName', surname: 'NewSurname', age: 7 } }
        expect(flash: [:success])
        get :show, params: { id: user.id }
        expect(response).to render_template('show')
      end
    end

    context 'invalid attributes' do
      it do
        put :update, params: { id: user.id, user: { first_name: nil, surname: 'NewSurname', age: 7 } }
        expect(flash: [:danger])
        expect(response).to render_template('edit')
      end
    end
  end

  describe '[DELETE] #destroy' do
    let(:article) { Article.create(title: 'Something', body: 'Another thing', user_id: user.id) }

    context 'delete an existing user' do
      it do
        delete :destroy, params: { id: user.id }
        expect(flash: [:success])
        expect(Article.where(user_id: article.user_id).count).to be 0
        get :index
        expect(response).to render_template('index')
      end
    end

    context 'delete a non-existent user' do
      it do
        delete :destroy, params: { id: 10_000 }
        expect(flash[:danger]).to include('User not found')
      end
    end
  end
end
