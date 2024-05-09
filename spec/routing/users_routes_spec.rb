# frozen_string_literal: true

require 'rails_helper'
require 'factories/users'

RSpec.describe 'routes for Users', type: :routing do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    create :user
  end

  describe 'index' do
    it do
      expect(get('/')).to route_to('users#index')
    end
  end

  describe 'sign in' do
    it do
      expect(get: '/users/sign_in').to route_to('devise/sessions#new')
    end
  end

  describe 'log out' do
    it do
      expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy')
    end
  end

  describe 'new' do
    it do
      expect(get: '/users/new').to route_to('users#new')
    end
  end

  describe 'show' do
    it do
      expect(get: "/users/#{user.id}").to route_to('users#show', id: user.id.to_s)
    end
  end

  describe 'create' do
    it do
      expect(post: '/users').to route_to('devise/registrations#create')
    end
  end

  describe 'edit' do
    it do
      expect(get: "/users/#{user.id}/edit").to route_to('users#edit', id: user.id.to_s)
    end
  end

  describe 'delete' do
    it do
      expect(delete: "/users/#{user.id}").to route_to('users#destroy', id: user.id.to_s)
    end
  end
end
