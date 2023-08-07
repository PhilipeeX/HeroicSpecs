require 'rails_helper'

RSpec.describe "Weapons", type: :request do
  describe "GET /weapons" do
    it "returns http success" do
      get "/weapons"
      expect(response).to have_http_status(:success)
    end

    it 'should return the name of the weapons' do
      FactoryBot.create(:weapon, name: 'espada de ouro')
      get "/weapons"

      expect(response.body).to include('espada de ouro')
    end

    it 'should return the current_power of the weapons' do
      FactoryBot.create(:weapon, level: 1, power_step: 50, power_base: 1000)
      get "/weapons"

      expect(response.body).to include('1000')
    end

    it 'should return the title of the weapons' do
      FactoryBot.create(:weapon, level: 1, name: 'The best weapon')
      get "/weapons"

      expect(response.body).to include("The best weapon #1")
    end
  end

  describe "POST /weapons" do
    it "should create weapon correctly" do
      weapon_attributes = FactoryBot.attributes_for(:weapon)
      post weapons_path, params: { weapon: weapon_attributes}
      expect(Weapon.last).to have_attributes(weapon_attributes)
    end

    it 'should not create weapon with invalid attributes' do
      weapon_attributes = FactoryBot.attributes_for(:weapon, level: 0)
      post weapons_path, params: { weapon: weapon_attributes}
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "DELETE /weapons/:id" do
    let!(:weapon) { create(:weapon) }

    it "deletes the weapon and redirects to the index page" do
      expect {
        delete weapon_path(weapon)
      }.to change(Weapon, :count).by(-1)

      expect(response).to redirect_to weapons_path
    end
  end

  describe "GET /weapons/:id" do
    let!(:weapon) { create(:weapon) }

    before do
      get weapon_path(weapon)
    end

    it "displays the weapon details" do
      expect(response.body).to include(weapon.name)
      expect(response.body).to include(weapon.description)
      expect(response.body).to include(weapon.level.to_s)
      expect(response.body).to include(weapon.power_base.to_s)
      expect(response.body).to include(weapon.power_step.to_s)
      expect(response.body).to include(weapon.current_power.to_s)
      expect(response.body).to include(weapon.title)
    end

    it "responds with success status" do
      expect(response).to have_http_status(200)
    end
  end
end
