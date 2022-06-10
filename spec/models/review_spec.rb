require 'rails_helper'

RSpec.describe Review, type: :model do
  describe "Review" do
    # test per Creazione
    describe "Create" do
      before do
        @drinker = Drinker.create(email: "test@test.it", password: "password")
        @review = Review.create(text: "Recensione di prova", vote: 5)
        @bar = Bar.create(name: "Bar di Prova", address: "Via della Prova", tel: "0000000000", description: "Descrizione di prova")
        @review.drinker = @drinker
        @review.bar = @bar
      end
      it "should be created a Drinker" do
        expect(@review).to be_valid
      end
  
      # test per Model validation
      describe "Validation" do
        it "should not be valid without a text" do
          @review.text = nil
          expect(@review).to_not be_valid
        end
        it "should be not valid without a vote" do 
          @review.vote = nil
          expect(@review).to_not be_valid
        end 
        it "should be not valid with a vote greater than 5" do 
          @review.vote = 6
          expect(@review).to_not be_valid
        end 
        it "should be not valid with a negative vote" do 
          @review.vote = -1
          expect(@review).to_not be_valid
        end 
      end

      # test per Associations
      describe "Associations" do
        it "Drinker has many reviews" do
          var = described_class.reflect_on_association(:reviews)
          expect(var.macro).to eq :has_many
        end
      end
    end
  end
end
