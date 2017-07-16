require 'rails_helper'

RSpec.describe ImagesController, type: :controller do

  describe 'GET #upload' do
    it 'returns http success' do
      get :upload
      expect(response).to have_http_status(:success)
    end
  end

  describe 'POST #perform_upload' do
    before do
      allow_any_instance_of(MontagesHelper).to receive(:import_csv).and_return(nil)
      @file = fixture_file_upload('files/sample.csv', 'text/csv')
      post :perform_upload, params: { images: { csv: @file } }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:redirect)
    end
  end

  describe 'GET #download' do
    describe 'with no montages' do
      it 'should redirect' do
        get :download
        expect(response).to have_http_status(:redirect)
      end
    end

    describe 'with montages' do
      before do
        create :montage
        allow_any_instance_of(MontagesHelper).to receive(:export_csv).and_return('1,2,3')
        get :download
      end

      it 'return csv' do
        expect(response.body).to eql '1,2,3'
        expect(response).to have_http_status(:success)
        expect(response.headers['Content-Type']).to eq 'text/csv'
        expect(response.headers['Content-Disposition']).to eq 'attachment; filename="montages.csv"'
      end
    end
  end

end
