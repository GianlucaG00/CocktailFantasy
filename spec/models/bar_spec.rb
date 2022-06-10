require 'rails_helper'

RSpec.describe Bar, type: :model do

  describe "Bar" do
    describe "Create a Bar" do
      before do
        @barman = Barman.create(name: "Prova", surname: "Prova", email: "prova@prova.it", password: "password")
        @bar = Bar.create(name: "Bar Prova", address: "Via della Prova 43, Roma", tel: "0000000000", description: "Descrizione di Prova", barman_id: @barman.id)
      end
      it "Should be created a Bar" do
        expect(@bar).to be_valid
      end
  
      describe "Bar Validation" do
        it "should not be valid without a name" do
          @bar.name = nil
          expect(@bar).to_not be_valid
        end
        it "should not be valid without a description" do
          @bar.description = nil
          expect(@bar).to_not be_valid
        end
      end

      # test per Associations
      describe "Associations" do
        it "Bar belongs to a Barman" do
          assc = described_class.reflect_on_association(:barman)
          expect(assc.macro).to eq :belongs_to
        end
      end
    end
  end

end
