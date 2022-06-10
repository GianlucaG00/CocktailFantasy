require 'rails_helper'

RSpec.describe Barman, type: :model do
  
  describe "Barman" do
    describe "Create a Barman" do
      before do
        @barman = Barman.create(name: "Gianluca", surname: "Prova", email: "gian@prova.it", password: "password")
      end
      it "Should be created a Barman" do
        expect(@barman).to be_valid
      end
  
      describe "Barman Validation" do
        it "should not be valid without a name" do
          @barman.name = nil
          expect(@barman).to_not be_valid
        end
        it "should not be valid without a surname" do
          @barman.surname = nil
          expect(@barman).to_not be_valid
        end
        it "should not be valid without an email" do
          @barman.email = nil
          expect(@barman).to_not be_valid
        end
      end

      # test per Associations
      describe "Associations" do
        it "Barman has many bars" do
          assc = described_class.reflect_on_association(:bars)
          expect(assc.macro).to eq :has_many
        end
      end
    end
  end

end