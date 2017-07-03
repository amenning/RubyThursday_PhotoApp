require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #site_index" do
    it "returns http success" do
      get :site_index
      expect(response).to have_http_status(:success)
    end
  end

end
