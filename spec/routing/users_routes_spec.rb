# frozen_string_literal: true

require 'rails_helper'
require 'factories/users'

RSpec.describe 'routes for Users', type: :routing do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    create :user
  end

  describe 'index' do
    it { expect(get('/')).to route_to('users#index') }
  end

  describe 'sign in' do
    it { expect(get: '/users/sign_in').to route_to('devise/sessions#new') }
  end

  describe 'log out' do
    it { expect(delete: '/users/sign_out').to route_to('devise/sessions#destroy') }
  end

  describe 'new' do
    it { expect(get: '/users/new').to route_to('users#new') }
  end

  describe 'show' do
    it { expect(get: "/users/#{user.id}").to route_to('users#show', id: user.id.to_s) }
  end

  describe 'create' do
    it { expect(post: '/users').to route_to('devise/registrations#create') }
  end

  describe 'edit' do
    it { expect(get: "/users/#{user.id}/edit").to route_to('users#edit', id: user.id.to_s) }
  end

  describe 'delete' do
    it { expect(delete: "/users/#{user.id}").to route_to('users#destroy', id: user.id.to_s) }
  end
end
