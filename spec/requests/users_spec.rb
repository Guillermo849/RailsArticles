require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.build(:user) }

  describe 'GET /index' do
    it 'assigns @user' do
      get :index
      expect(assigns(:user)).to eq([])
    end

    it 'renders the index page' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET /show' do
    it 'gets specific @user' do
      get :show, params: { id: user.id }
      expect(response).to redirect_to(users_path { user.id })
    end
  end

  describe 'GET /new' do
    it 'new @user' do
      get :new
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /edit' do
    it 'render edit page' do
      get :edit, params: { id: user.id }
      expect(response).to redirect_to(users_path { 'edit' })
    end
  end

  describe 'PUT /update' do
    context 'valid attributes' do
      it 'update user' do
        put :update, params: { id: user.id, user: { first_name: 'NewFirstName', surname: 'NewSurname', age: 7 } }
        expect(response).to have_http_status(302)
      end
    end
  end

  describe 'POST /create' do
    context 'with valid attributes' do
      it 'new @user' do
        post :create, params: { user: { first_name: user.first_name, surname: user.surname, age: user.age } }
        expect(response).to have_http_status(302)
      end

      it 'Redirects to new user page' do
        get :show, params: { id: user.id }
        expect(response).to redirect_to(users_path { user.id })
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'existing user' do
      it 'destroy user' do
        delete :destroy, params: { id: user.id }
        expect(response).to redirect_to(users_url)
      end
    end

    context 'delete a non-existent user' do
      it 'creates an error message' do
        delete :destroy, params: { id: 10_000 }
        expect(flash[:danger]).to include('User not found')
      end
    end
  end
end
