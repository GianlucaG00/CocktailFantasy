require 'rails_helper'

RSpec.describe BarsController, type: :controller do
  describe "Bar Controller" do 
    it "creates a user" do
      expect(Bar).to receive(:index)
      get :index
    end
  end
end