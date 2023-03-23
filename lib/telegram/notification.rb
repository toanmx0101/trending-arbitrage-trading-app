require 'telegram/bot'
require "simple_command"

module Telegram
  class Notification
    TOKEN = "5366752306:AAFoweI08d9fsg9c8M8dY2KAS59beYSQF3I"
    CHAT_ID = "-1001582041915"

    attr_accessor :bot

    def send_message message
      bot.api.send_message(
        chat_id: "-1001582041915",
        text: message,
        parse_mode: "Markdown",
        disable_web_page_preview: true
      )
    end

    def bot
      @bot ||= Telegram::Bot::Client.new(TOKEN)
    end
  end
end
