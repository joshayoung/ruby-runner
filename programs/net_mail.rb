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
From: Josh Young <josh.young@daveramsey.com>
To: Josh Young <josh.young@daveramsey.com>
Subject: Test Email Send

Does this get sent?
MESSAGE_END

s = Net::SMTP.new("smtp.gmail.com", 587)
s.enable_starttls
sp = s.start('daveramsey.com', vault_credentials[ENV['VAULT_USER'].to_sym], vault_credentials[ENV['VAULT_PASS'].to_sym], :login)
sp.send_message(message, 'josh.young@daveramsey.org', 'josh.young@daveramsey.com')
sp.finish()