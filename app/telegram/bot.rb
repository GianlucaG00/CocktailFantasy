require File.expand_path("../config/environment")
require 'telegram/bot'

token = "5305253621:AAE9ff-75kqLnlyCiIpyXH1Dso69wvD2vDE"
class Bot
    def inizitalize
        Telegram::Bot::Client.run(token) do |bot|
            help = "Ciao! Io sono il Bot di COCKTAIL FANTASY.\n\nQuesti sono i comandi che puoi utilizzare:\n
            /subscribe : permette l'iscrizione alle notifiche di uno specifico bar; 
            /unsubscribe: permette la disiscrizione dalle notifiche di uno specifico bar"
            bot.listen do |message|
                # controllo
                if !Chat.exists?(chat_id: message.chat.id)
                    # un nuovo utente ha scritto al bot
                    bot.api.send_message(chat_id: message.chat.id, text: help)
                end
                case message.tex
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
                            Chat.create(chat_id: message.chat.id, bar_id: nil)
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
end
