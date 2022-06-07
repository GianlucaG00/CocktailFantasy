class TelegramMailer < ApplicationMailer

    # Invia Notifiche
    def send_notification(text)
        api_key = "5305253621:AAE9ff-75kqLnlyCiIpyXH1Dso69wvD2vDE"
        chat_id = "726564883"
        
        HTTParty.post("https://api.telegram.org/bot#{api_key}/sendMessage",
            headers: {
                'Content-Type' => 'application/json'
            },
            body: {
                chat_id: chat_id,
                text: text
            }.to_json
        )

    end 
end
