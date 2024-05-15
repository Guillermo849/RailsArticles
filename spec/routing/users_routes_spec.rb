# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :routing do
  describe '[GET] #index' do
    it { expect(get('/')).to route_to('users#index') }
  end

  describe '[GET] #new' do
    it { expect(get: '/users/new').to route_to('users#new') }
  end

  describe '[GET] #show' do
    it { expect(get: '/users/1').to route_to('users#show', id: '1') }
  end

  describe '[POST] #create' do
    it { expect(post: '/users').to route_to('devise/registrations#create') }
  end

  describe '[GET] #edit' do
    it { expect(get: '/users/1/edit').to route_to('users#edit', id: '1') }
  end

  describe '[DELETE] #delete' do
    it { expect(delete: '/users/1').to route_to('users#destroy', id: '1') }
  end
end
