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

message = <<MESSAGE_END
From: Private Person <me@fromdomain.com>
To: A Test User <test@todomain.com>
Subject: SMTP e-mail test

This is a test e-mail message.
MESSAGE_END

# Net::SMTP.start('smtp.office365.com', 465, 'localhost', '', '', :plain) do |smtp|
# s.starttls
# s.enable_starttls = true
# s.enable_tls = true
# s.enable_starttls_auto = true
# s.ssl = true
# s.tls = true
#sp.start('smtp.gmail.com', 587, 'localhost', vault_credentials[ENV['VAULT_USER'].to_sym], vault_credentials[ENV['VAULT_PASS'].to_sym], :login) do |smtp|
# smtp.enable_starttls
# smtp.enable_starttls_auto
# smtp.starttls
# smtp.enable_tls
# smtp.starttls
s = Net::SMTP.new("smtp.gmail.com", 587)
s.enable_starttls
sp = s.start('daveramsey.com', vault_credentials[ENV['VAULT_USER'].to_sym], vault_credentials[ENV['VAULT_PASS'].to_sym], :login)
sp.send_message(message, 'josh.young@daveramsey.org', 'josh.young@daveramsey.com')
sp.finish()