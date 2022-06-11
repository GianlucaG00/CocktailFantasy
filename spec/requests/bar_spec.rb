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

      it 'should returns a 200 status code' do
        get bars_path
        expect(response.status).to eq(200)
      end
    end


    describe "Display the bars" do
      it "should display the new bars" do
        get "/barman/sign_in"
        fill_in "email", :with => @barman.email
        fill_in "password", :with => @barman.password
        click_button "Login"
        #visit bar_path(bar.id)
        visit barmen_personalArea_path
        page.should have_link("Elimina")
        expect { click_link "Elimina" }.to change(Bar, :count).by(-1)
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
        expect(response).to redirect_to("http://localhost/bars?#{prova}&commit=Cerca")
      end
    end
  end
end
