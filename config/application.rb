require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)  

require 'telegram/bot'


def startBot 
  help = "Ciao! Io sono il Bot di COCKTAIL FANTASY.\n\nQuesti sono i comandi che puoi utilizzare:\n
  /subscribe : permette l'iscrizione alle notifiche di uno specifico bar; 
  /unsubscribe: permette la disiscrizione dalle notifiche di uno specifico bar"
  token = '...'

  Telegram::Bot::Client.run(token) do |bot|
    bot.listen do |message|
      # controllo
      if !Chat.exists?(chat_id: message.chat.id)
          # un nuovo utente ha scritto al bot
          bot.api.send_message(chat_id: message.chat.id, text: help)
      end

      # messaggi dell'utente
      case message.text
      # HELPER
      when "/help"
          bot.api.send_message(chat_id: message.chat.id, text: help)
      # iscrizione al BAR
      when "/subscribe"
          bot.api.send_message(chat_id: message.chat.id, text: "Bene ora dimmi il nome del Bar da cui vuoi ricevere le notifiche")
          bot.listen do |bar|
              if(bar.text == "BAR") 
                  bot.api.send_message(chat_id: message.chat.id, text: "Iscrizione effettuata con successo!")
                  puts "PARAMETRO CORRETTO"
                  if !Chat.exists?(chat_id: message.chat.id)
                    Chat.create(chat_id: message.chat.id, bar_id: nil)
                  end
                  break
              else
                  bot.api.send_message(chat_id: message.chat.id, text: "Non esiste alcun bar con quel nome!")
                  puts "NON CORRETTO: ELSE"
                  break
              end
          end
      when "/unsubscribe"
          bot.api.send_message(chat_id: message.chat.id, text: "Bene ora dimmi il nome del Bar da cui vuoi disiscriverti")
          bot.listen do |bar|
              if(bar.text == "BAR") 
                  bot.api.send_message(chat_id: message.chat.id, text: "Iscrizione effettuata con successo!")
                  puts "PARAMETRO CORRETTO"
                  break
              else
                  bot.api.send_message(chat_id: message.chat.id, text: "Non esiste alcun bar con quel nome!")
                  puts "NON CORRETTO: ELSE"
                  break 
              end
          end
      end
      puts message
  end   
  end 
end 
def function
  Thread.new {
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
  
    function()
  end
end
 

