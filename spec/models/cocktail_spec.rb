require 'rails_helper'

RSpec.describe Cocktail, type: :model do
  describe "Cocktail" do
    describe "Create a Cocktail" do
      before do
        @cocktail = Cocktail.create(name: "Cocktail Prova", price: 12, preparation: "Test preparation", ingredients: "IngredienteA,IngredienteB")
        @bar = Bar.create(name: "Bar Prova", address: "Via della Prova 43, Roma", tel: "0000000000", description: "Descrizione di Prova")
        @barman = Barman.create(name: "Prova", surname: "Prova", email: "email@email.it", password: "password")
        @bar.barman = @barman
        @cocktail.bar = @bar
      end
      it "should be created a Cocktail" do
        expect(@cocktail).to be_valid
      end

      describe "Validation" do 
        it "should not be valid without a name" do
          @cocktail.name = nil
          expect(@cocktail).to_not be_valid
        end
        it "should not be valid without a preparation" do
          @cocktail.preparation = nil
          expect(@cocktail).to_not be_valid
        end
        it "should be valid with the right forma of the ingredients" do 
          @cocktail.ingredients = "IngredienteA,IngredienteB,IngredienteC"
          expect(@cocktail).to be_valid
        end 
        it "should not be valid to create a Cocktail with same name for the same Bar" do 
          # Non ci possono essere due cocktail con lo stesso nome per uno stesso bar
          @cocktail1 = Cocktail.create
          @cocktail1.bar_id = 80
          @cocktail1.name = "TEST"
          @cocktail1.save
          @cocktail2 = Cocktail.create
          @cocktail2.bar_id = 80
          @cocktail2.name = "TEST"

          expect {
              @cocktail2.save!
          }.to raise_error(ActiveRecord::RecordInvalid)
        end
        
      end

      describe "Associations" do
        it "belongs to a bar" do
          var = described_class.reflect_on_association(:bar)
          expect(var.macro).to eq :belongs_to 
        end 

      end 

      describe 
    end 
  end

end
