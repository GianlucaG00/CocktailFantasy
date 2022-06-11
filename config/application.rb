require_relative "boot"

require "rails/all"
require "telegram/bot"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)  

def startBot 
  token = "5305253621:AAE9ff-75kqLnlyCiIpyXH1Dso69wvD2vDE"
  help = "Ciao! Io sono il Bot di COCKTAIL FANTASY.\n\nEcco i comandi che puoi usare:\n
-/password id_utente password_utente: riconoscimento e registrazione al servizio di notifiche Cocktail Fantasy;\n
-/help per visualizzare l'elenco dei comandi"

  Telegram::Bot::Client.run(token) do |bot|
    puts "BOT AVVIATO"
    bot.listen do |message|
      case message.text

      # per il riconoscimento su Telegram
      when /\/password [0-9]* [\w]*/
        array = message.text.split(" ")
        id_utente = array[1]
        password = array[2]
        if(Drinker.exists?(id: id_utente))
          if(Drinker.find(id_utente).valid_password?(password))
            bot.api.send_message(chat_id: message.chat.id, text: "Password corretta! Sei stato correttamente riconosciuto!")
            Drinker.find(id_utente).update(chat_id: message.chat.id)
          else
            bot.api.send_message(chat_id: message.chat.id, text: "Password non corretta! Riprovare")
          end 
        else 
          bot.api.send_message(chat_id: message.chat.id, text: "L'id inserito non corrisponde a nessun utente.")
        end 

      # helper dei comandi 
      when '/help'
        bot.api.send_message(chat_id: message.chat.id, text: help)
      end
      
      puts message
    end
  end 
end   

def function
  Thread.new{
    startBot()
  }
end


module CocktailFantasy4
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
  
    # il Bot si avvia in un Thread 
    function()
  end
end
 

