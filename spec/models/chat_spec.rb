require 'rails_helper'

RSpec.describe Chat, type: :model do
  describe "Chat" do
    # test per Creazione
    describe "create" do
      before do
        @drinker = Drinker.create(email: "test@test.it", password: "password")
        @bar = Bar.create(name: "Bar di Prova", address: "Via della Prova", tel: "0000000000", description: "Descrizione di prova")
        @chat = Chat.create()
        @chat.bar = @bar
        @chat.drinker = @drinker
        
      end
      it "should be created a Drinker" do
        expect(@chat).to be_valid
      end
  
      # test per Model validation
      describe "Validation" do
        it "should not be valid without a bar" do
            @chat.bar = nil
            expect(@chat).to_not be_valid
          end
          it "should not be valid without a drinker" do
            @chat.drinker = nil
            expect(@chat).to_not be_valid
          end
          it "should not be valid to create a Chat with same bar_id and drinker_id" do 
            # bar_id e drinker_id formauno una superchiave 
            @chat1 = Chat.create
            @chat1.bar_id = 2
            @chat1.drinker_id = 2
            @chat1.save
            @chat2 = Chat.create
            @chat2.bar_id = 2
            @chat2.drinker_id = 2

            expect {
                @chat2.save!
            }.to raise_error(ActiveRecord::RecordInvalid)
          end
      end

      # test per Associations
      describe "Associations" do 
        it "belongs to a drinker" do
            var = described_class.reflect_on_association(:drinker)
            expect(var.macro).to eq :belongs_to
        end
        it "belongs to a bar" do
            var = described_class.reflect_on_association(:bar)
            expect(var.macro).to eq :belongs_to
        end
      end
    end
  end
end