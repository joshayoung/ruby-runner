require 'net/smtp'
require "vault"
require "mail"
require "pry-byebug"
require "dotenv"

Dotenv.load

Vault.configure do |config|
  config.address = ENV["VAULT_URL"]
  config.token = ENV["VAULT_TOKEN"]
end

def vault_credentials
  values = ""
  Vault.with_retries(Vault::HTTPConnectionError) do
    values = Vault.logical.read(ENV["VAULT_PATH"])
  end
  values.data[:data]
end

def user_name
  # Some SMTP servers need the full email address for the user name:
  "#{vault_credentials[ENV['VAULT_USER'].to_sym]}@#{ENV['EMAIL_DOMAIN']}"
end

def password
  vault_credentials[ENV['VAULT_PASS'].to_sym]
end

message = <<MESSAGE_END
From: Josh Young <josh.young@daveramsey.com>
To: Josh Young <josh.young@daveramsey.com>
Subject: Test Email Send

Does this get sent?
MESSAGE_END

smtp = Net::SMTP.new(ENV['EMAIL_HOST'], ENV['EMAIL_PORT'])
smtp.enable_starttls
smtp_start = smtp.start(ENV['EMAIL_DOMAIN'], user_name, password, :login)
smtp_start.send_message(message, ENV['EMAIL_FROM'], ENV['EMAIL_TO'])
smtp_start.finish()
