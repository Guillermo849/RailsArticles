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
        expect(flash[:danger]).to eq('User not found')
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
    let(:params) { { first_name: user.first_name, surname: user.surname, age: user.age } }
    context 'when params are valid' do
      before do
        post :create, params: { user: params }
      end

      it do
        expect(flash[:success]).to eq('New users successfully created')
      end
    end

    context 'when params are not valid' do
      before do
        post :create, params: {
          user: { first_name: nil, surname: user.surname, age: user.age }
        }
      end

      it do
        expect(flash[:danger]).to eq('User creation failed')
        expect(response).to render_template('new')
      end
    end
  end

  describe '[GET] #edit' do
    context 'when user is found' do
      before { get :edit, params: { id: user.id } }

      it do
        expect(response).to render_template('edit')
        expect(assigns(:user)).to eq(user)
      end
    end

    context 'when user is not found' do
      before { get :edit, params: { id: 10_000 } }

      it do
        expect(flash[:danger]).to include('User not found')
      end
    end
  end

  describe '[PUT] #update' do
    let(:params) { { first_name: 'NewFirstName', surname: 'NewSurname', age: 7 } }
    context 'when valid params' do
      before do
        put :update, params: { id: user.id, user: params }
      end

      it do
        expect(User.find_by(*params[:user], id: user.id)).not_to be nil
        expect(flash[:success]).to eq('User successfully updated')
      end
    end

    context 'when invalid params' do
      before do
        put :update, params: {
          id: user.id,
          user: { first_name: nil, surname: 'NewSurname', age: 7 }
        }
      end

      it do
        expect(flash[:danger]).to eq('User update failed')
        expect(response).to render_template('edit')
      end
    end
  end

  describe '[DELETE] #destroy' do
    let(:article) { build :article, user_id: user }
    context 'delete an existing user' do
      before { delete :destroy, params: { id: user.id } }

      it do
        expect(flash[:success]).to eq('User successfully deleted')
        expect(User.find_by(id: user.id)).to be nil
        expect(Article.find_by(id: article.id)).to be nil
      end
    end

    context 'delete a non-existent user' do
      before { delete :destroy, params: { id: 10_000 } }

      it do
        expect(flash[:danger]).to include('User not found')
      end
    end
  end
end
