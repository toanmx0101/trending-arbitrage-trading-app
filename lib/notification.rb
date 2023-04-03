require 'telegram/bot'
require "simple_command"

class Notification
  TOKEN = ENV["TELE_TOKEN"]
  CHAT_ID = ENV["CHAT_ID"]

  attr_accessor :bot

  def initialize(chat_id = CHAT_ID, token = TOKEN)
    @chat_id = chat_id
    @token = token
  end

  def send_message message
    bot.api.send_message(
      chat_id: @chat_id,
      text: message,
      parse_mode: "Markdown",
      disable_web_page_preview: true
    )
  end

  def bot
    @bot ||= Telegram::Bot::Client.new(@token)
  end
end
