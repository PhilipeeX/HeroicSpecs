require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "returns success status" do
      get users_path
      expect(response).to have_http_status(:success)
    end
    it 'should have the user title present' do
      users = create_list(:user, 3)
      get users_path
      users.each do |user|
        expect(response.body).to include(user.title)
      end
    end
  end

  describe "POST /users" do
    context 'when it has valid params' do
      it 'creates the user with correct attributes' do
        user_attributes = FactoryBot.attributes_for(:user)
        post users_path, params: { user: user_attributes}
        expect(User.last).to have_attributes(user_attributes)
      end
    end
  end
end
