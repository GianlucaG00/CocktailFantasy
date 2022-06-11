require 'rails_helper'

RSpec.describe "Bars", type: :request do
  describe "GET /index" do
    before :each do
      @bar = Bar.create(name: "Bar Prova", description: "Bar della Prova", tel: "0000000000", address: "Via della Prova 25, Roma")
      @barman = Barman.create(name: "prova", surname: "prova", email: "prova@prova.it", password: "prova123")
      @bar.barman = @barman
    end
  
    describe "GET bar list" do
      it "should returns a 200 status code" do
        get "/bars"
        expect(response.status).to eq(200)
      end
    end
  
    describe "Search a Bar" do
      it "should be return the bar" do
        stringa = "prova"
        redirect_to bars_path
        within("#search") do
          fill_in stringa
        end
        click_button("commit")  # submit della form
        #expect(page).to have_content 'You have signed up successfully'
        expect(response.body).to include "Bar Prova"
      end
    end
  end
end
