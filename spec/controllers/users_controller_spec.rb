# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { create :user }

  describe '[GET] #index' do
    before do
      sign_in user
      get :index
    end

    it do
      expect(assigns(:users)).to eq([user])
      expect(response).to render_template('index')
    end
  end

  describe '[GET] #show' do
    context 'when user was found' do
      before do
        sign_in user
        get :show, params: { id: user.id }
      end

      it do
        expect(assigns(:user)).to eq(user)
        expect(response).to render_template('show')
      end
    end
  end

  describe '[GET] #new' do
    before do
      sign_in user
      get :new
    end

    it 'renders new user template' do
      expect(response).to render_template('new')
    end
  end

  # TODO: Refactor Test for user creation after pundit implementation
  # describe '[POST] #create' do
  #   let(:params) do
  #     { first_name: user.first_name, surname: user.surname, age: user.age, email: user.email, password: user.password }
  #   end

  #   context 'when params are valid' do
  #     before do
  #       sign_in user
  #       post :create, params: { user: params }
  #     end

  #     it do
  #       expect(User.find_by(**params[:user], id: user.id)).not_to be nil
  #       expect(flash[:success]).to eq('New users successfully created')
  #     end
  #   end

  #   context 'when params are not valid' do
  #     before do
  #       sign_in user
  #       params[:first_name] = nil
  #       post :create, params: { user: params }
  #     end

  #     it do
  #       expect(flash[:danger]).to eq('User creation failed')
  #       expect(response).to render_template('new')
  #     end
  #   end
  # end

  describe '[GET] #edit' do
    context 'when user is found' do
      before do
        sign_in user
        get :edit, params: { id: user.id }
      end

      it do
        expect(response).to render_template('edit')
        expect(assigns(:user)).to eq(user)
      end
    end

    # TODO: when user found and not found test
    # context 'when user not found' do
    #   it do
    #     expect(flash[:danger]).to include('User not found')
    #   end
    # end
  end

  describe '[PUT] #update' do
    let(:params) do
      { id: user.id, user: { first_name: 'NewFirstName', surname: 'NewSurname', age: 7 } }
    end

    before do
      sign_in user
      put :update, params: params
    end

    context 'when valid params' do
      it do
        expect(User.find_by(**params[:user], id: user.id)).not_to be nil
        expect(flash[:success]).to eq('User successfully updated')
      end
    end

    context 'when invalid params' do
      before do
        params[:user][:first_name] = nil
        put :update, params: params
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
      before do
        sign_in user
        delete :destroy, params: { id: user.id }
      end

      it do
        expect(flash[:success]).to eq('User successfully deleted')
        expect(User.find_by(id: user.id)).to be nil
        expect(Article.find_by(id: article.id)).to be nil
      end
    end
  end
end
