require 'rails_helper'

RSpec.describe Drinker, type: :model do
  
  describe "Drinker" do
    # test per Creazione
    describe "Create" do
      before do
        @drinker = Drinker.create(email: "test@test.it", password: "password")
      end
      it "should be created a Drinker" do
        expect(@drinker).to be_valid
      end
  
      # test per Model validation
      describe "validation" do
        it "should not be valid without an email" do
          @drinker.email = nil
          expect(@drinker).to_not be_valid
        end
        it "should not be valid without a password" do
          @drinker.password = nil
          expect(@drinker).to_not be_valid
        end
        it "should not be valid with a password with less than 6 characters" do 
          @drinker.password = "....."
          expect(@drinker).to_not be_valid
        end 
      end

      # test per Associations
      describe "Associations" do
        it "has many reviews" do
          var = described_class.reflect_on_association(:reviews)
          expect(var.macro).to eq :has_many
        end
        it "has many chats" do
          var = described_class.reflect_on_association(:chats)
          expect(var.macro).to eq :has_many
        end 
      end
    end
  end

end