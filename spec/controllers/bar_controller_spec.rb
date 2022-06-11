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

  describe "Display the bars" do
    it "should display the new bars" do
      @bar1 = Bar.create(name: "Prova1", description: "Descrizione1", address: "Via della Prova1", tel: "1111111111") 
      @bar2 = Bar.create(name: "Prova2", description: "Descrizione2", address: "Via della Prova2", tel: "2222222222")
      expect(assigns(:bars)).to match_array([@bar1, @bar2])
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