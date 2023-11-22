require 'rails_helper'

RSpec.describe Api::V1::ApplicationController, type: :controller do
  describe 'GET /some_path' do
    it 'returns HTTP 405 for non-POST requests' do

      # Make a non-POST request to some_path
      get :method_not_allowed, params: { path: 'some_path' }

      expect(response).to have_http_status(:method_not_allowed)
    end
  end
end
