# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :routing do
  describe '[GET] #index' do
    let(:path) {  '/users/1/articles' }

    it do
      expect(get: path).to route_to('articles#index', user_id: '1')
    end
  end

  describe '[GET] #new' do
    let(:path) {  '/users/1/articles/new' }

    it do
      expect(get: path).to route_to('articles#new', user_id: '1')
    end
  end

  describe '[GET] #show' do
    let(:path) {  '/users/1/articles/2' }

    it do
      expect(get: path).to route_to('articles#show', user_id: '1', id: '2')
    end
  end

  describe '[POST] #create' do
    let(:path) { '/users/1/articles' }

    it do
      expect(post: path).to route_to('articles#create', user_id: '1')
    end
  end

  describe '[GET] #edit' do
    let(:path) {  '/users/1/articles/2/edit' }

    it do
      expect(get: path).to route_to('articles#edit', user_id: '1', id: '2')
    end
  end

  describe '[DELETE] #delete' do
    let(:path) { '/users/1/articles/2' }

    it do
      expect(delete: path).to route_to('articles#destroy', user_id: '1', id: '2')
    end
  end
end
