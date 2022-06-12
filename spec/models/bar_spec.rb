require 'rails_helper'

RSpec.describe Bar, type: :model do

  describe "Bar" do
    describe "Create a Bar" do
      before do
        @barman = Barman.create(name: "Prova", surname: "Prova", email: "prova@prova.it", password: "password")
        @bar = Bar.create(name: "Bar Prova", address: "Via della Prova 43, Roma", tel: "0000000000", description: "Descrizione di Prova", barman_id: @barman.id)
      end
      it "should be created a Bar" do
        expect(@bar).to be_valid
      end
  
      describe "Validation" do
        it "should not be valid without a name" do
          @bar.name = nil
          expect(@bar).to_not be_valid
        end
        it "should not be valid without a description" do
          @bar.description = nil
          expect(@bar).to_not be_valid
        end
        it "should not be valid without a Barman" do 
          @bar.barman = nil
          expect(@bar).to_not be_valid
        end
        it "should not be valid with a short number tel" do 
          @bar.tel = "1"
          expect(@bar).to_not be_valid
        end
        it "should not be valid with an invalid number tel" do 
          @bar.tel = "non sono numeri"
          expect(@bar).to_not be_valid
        end
      end

      # test per Associations
      describe "Associations" do
        it "belongs to a Barman" do
          var = described_class.reflect_on_association(:barman)
          expect(var.macro).to eq :belongs_to
        end
        it "has many reviews" do 
          var = described_class.reflect_on_association(:reviews)
          expect(var.macro).to eq :has_many
        end 
        it "has many cocktails" do 
          var = described_class.reflect_on_association(:cocktails)
          expect(var.macro).to eq :has_many
        end 
        it "has many chat" do   
          var = described_class.reflect_on_association(:chats)
          expect(var.macro).to eq :has_many
        end
      end

    end
  end
end
