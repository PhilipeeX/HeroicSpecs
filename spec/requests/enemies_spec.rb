require 'rails_helper'

RSpec.describe "Enemies", type: :request do
  describe "GET /enemies" do
    context 'when there are enemies' do
      let!(:enemies) { create_list(:enemy, 5) }

      before { get '/enemies' }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns all enemies' do
        json_response = JSON.parse(response.body)
        expect(json_response.size).to eq(5)
      end
    end

    context 'when there are no enemies' do
      before { get '/enemies' }

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns an empty array' do
        json_response = JSON.parse(response.body)
        expect(json_response).to be_empty
      end
    end
  end

  describe 'GET /enemies/:enemy' do
    it 'returns the correct information of the enemy' do
      enemy = create(:enemy, name: 'behemooth', level: 15)

      get "/enemies/#{enemy.id}"

      expect(response.body).to include('behemooth')
      expect(response.body).to include('15')
    end
  end

  describe 'POST /enemies' do
    it 'create enemy correctly' do
      enemy_params = FactoryBot.attributes_for(:enemy)

      post "/enemies", params: { enemy: enemy_params}
      expect(response).to have_http_status(:created)
      expect(Enemy.last).to have_attributes(enemy_params)
    end
  end


  describe "PUT /enemies" do
    context 'when the enemy exist' do
      it 'return status code 200' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: {enemy: enemy_attributes}
        expect(response).to have_http_status(200)
      end

      it 'updates the record' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: {enemy: enemy_attributes}

        expect(enemy.reload).to have_attributes(enemy_attributes)
      end
      it 'return the enemy updated' do
        enemy = create(:enemy)
        enemy_attributes = attributes_for(:enemy)
        put "/enemies/#{enemy.id}", params: {enemy: enemy_attributes}

        json_response = JSON.parse(response.body)
        expect(enemy.reload).to have_attributes(json_response.except('created_at', 'updated_at'))
      end
    end

    context 'when the enemy dont exist'
      it 'returns status code 404' do
        put '/enemies/0', params: attributes_for(:enemy)

        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        put '/enemies/0', params: attributes_for(:enemy)
        expect(response.body).to match(/Couldn't find Enemy/)
      end
  end

  describe 'DELETE /enemies' do
    context 'when the enemy exists' do
      it 'returns status code 204' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect(response).to have_http_status(204)
      end
      it 'destroy the record' do
        enemy = create(:enemy)
        delete "/enemies/#{enemy.id}"
        expect { enemy.reload }.to raise_error ActiveRecord::RecordNotFound
      end
    end

    context 'when the enemy does not exist' do
      it 'returns status code 404' do
        delete '/enemies/0'
        expect(response).to have_http_status(404)
      end
      it 'returns a not found message' do
        delete '/enemies/0'
        expect(response.body).to match(/Couldn't find Enemy/)
      end
    end

  end

end
