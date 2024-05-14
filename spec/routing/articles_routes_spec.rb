# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ArticlesController', type: :routing do
  describe '[GET] #index' do
    it do
      expect(get: '/users/1/articles').to route_to('articles#index', user_id: '1')
    end
  end

  describe '[GET] #new' do
    it do
      expect(get: '/users/1/articles/new').to route_to('articles#new', user_id: '1')
    end
  end

  describe '[GET] #show' do
    it do
      expect(get: '/users/1/articles/2').to route_to('articles#show', user_id: '1',
                                                                      id: '2')
    end
  end

  describe '[POST] #create' do
    it do
      expect(post: '/users/1/articles').to route_to('articles#create', user_id: '1')
    end
  end

  describe '[GET] #edit' do
    it do
      expect(get: '/users/1/articles/2/edit').to route_to('articles#edit', user_id: '1',
                                                                           id: '2')
    end
  end

  describe '[DELETE] #delete' do
    it do
      expect(delete: '/users/1/articles/2').to route_to('articles#destroy', user_id: '1',
                                                                            id: '2')
    end
  end
end
