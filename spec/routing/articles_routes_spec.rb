# frozen_string_literal: true

require 'rails_helper'
require 'factories/users'
require 'factories/articles'

RSpec.describe 'routes for Articles', type: :routing do
  include Devise::Test::IntegrationHelpers

  let(:user) do
    create :user
  end
  let(:article) do
    create :article
  end

  describe 'index' do
    it do
      expect(get: "/users/#{user.id}/articles").to route_to('articles#index', user_id: user.id.to_s)
    end
  end

  describe 'new' do
    it do
      expect(get: "/users/#{user.id}/articles/new").to route_to('articles#new', user_id: user.id.to_s)
    end
  end

  describe 'show' do
    it do
      expect(get: "/users/#{user.id}/articles/#{article.id}").to route_to('articles#show', user_id: user.id.to_s,
                                                                                           id: article.id.to_s)
    end
  end

  describe 'create' do
    it do
      expect(post: "/users/#{user.id}/articles").to route_to('articles#create', user_id: user.id.to_s)
    end
  end

  describe 'edit' do
    it do
      expect(get: "/users/#{user.id}/articles/#{article.id}/edit").to route_to('articles#edit', user_id: user.id.to_s,
                                                                                                id: article.id.to_s)
    end
  end

  describe 'delete' do
    it do
      expect(delete: "/users/#{user.id}/articles/#{article.id}").to route_to('articles#destroy', user_id: user.id.to_s,
                                                                                                 id: article.id.to_s)
    end
  end
end
