require 'rails_helper'

describe BarsController, type: :controller do
  before :each do
    @bar = Bar.create(name: "Bar Prova", description: "Bar della Prova", tel: "0000000000", address: "Via della Prova 25, Roma")
    @barman = Barman.create(name: "prova", surname: "prova", email: "prova@prova.it", password: "prova123")
    @bar.barman = @barman
  end

  describe "GET bar list" do
    it 'should returns a 200 status code' do
      get "/bars"
      expect(response.status).to eq(200)
    end
  end

  describe 'Update a Bar' do

    it 'should render the profile form' do
      get bars
      expect(response).to render_template('index')
    end
  end

end

