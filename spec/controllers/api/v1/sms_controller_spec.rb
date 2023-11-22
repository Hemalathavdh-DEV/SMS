require 'rails_helper'

RSpec.shared_examples 'returns HTTP status for various scenarios' do |http_status, request_params|
  it "returns HTTP #{http_status} for #{request_params}" do
    request.headers['Authorization'] = ActionController::HttpAuthentication::Basic.encode_credentials("jeee", "89999")
    post action, params: request_params
    expect(response).to have_http_status(http_status)
  end
end

RSpec.describe Api::V1::SmsController, type: :controller do
  describe 'POST /inbound/sms' do
    let(:action) { :inbound_sms }
    it 'returns HTTP 403 for unauthorized requests' do
      valid_request = { from: '123456', to: '654321', text: 'Hello World' }
      request.headers['Authorization'] = ActionController::HttpAuthentication::Basic.encode_credentials("jeee", "9999")
      post :inbound_sms, params: valid_request
      expect(response).to have_http_status(:forbidden)
    end

    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '', to: '654321', text: 'Hello World' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '', to: '', text: 'Hello World' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '', to: '', text: '' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { to: '122344', text: 'Hi' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '899999', text: 'Hii' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '999999', to: '999998' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '99999', to: '999998', text: 'Hii' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '99999', to: '99999899999999999999999999999999999', text: 'Hii' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '123456', to: '654321', text: 'Hello World' }
    it_behaves_like 'returns HTTP status for various scenarios', :ok, { from: '123456', to: '999999999999', text: 'Hello World' }
    it_behaves_like 'returns HTTP status for various scenarios', :ok, { from: '123456', to: '999999999999', text: 'stop' }
    it_behaves_like 'returns HTTP status for various scenarios', :ok, { from: '123456', to: '999999999999', text: 'stop' }
  end

  describe 'POST /outbound/sms' do
    let(:action) { :outbound_sms }

    it 'returns HTTP 403 for unauthorized requests' do
      valid_request = { from: '123456', to: '654321', text: 'Hello World' }
      request.headers['Authorization'] = ActionController::HttpAuthentication::Basic.encode_credentials("jeee", "9999")
      post :outbound_sms, params: valid_request
      expect(response).to have_http_status(:forbidden)
    end

    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '', to: '654321', text: 'Hello World' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '', to: '', text: 'Hello World' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '', to: '', text: '' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { to: '122344', text: 'Hi' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '899999', text: 'Hii' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '999999', to: '999998' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '99999', to: '999998', text: 'Hii' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '99999', to: '99999899999999999999999999999999999', text: 'Hii' }
    it_behaves_like 'returns HTTP status for various scenarios', :unprocessable_entity, { from: '123456', to: '654321', text: 'Hello World' }
    it_behaves_like 'returns HTTP status for various scenarios', :ok, { from: '999999999999', to: '167733', text: 'Hello World' }
  end
end

