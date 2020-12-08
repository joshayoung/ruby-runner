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

def email_address
  return ENV["EMAIL_TO"] if (ENV["EMAIL_TO"] != nil && ENV["EMAIL_TO"] != "")

  "#{vault_credentials[:email_user_name]}@#{ENV['EMAIL_DOMAIN']}"
end

Mail.defaults do
  delivery_method :smtp, {
    address: ENV['EMAIL_HOST'],
    port: ENV['EMAIL_PORT'],
    domain: ENV['EMAIL_DOMAIN'],
    user_name: vault_credentials[ENV['VAULT_USER'].to_sym],
    password: vault_credentials[ENV['VAULT_PASS'].to_sym],
    authentication: ENV["EMAIL_AUTH_TYPE"],
    enable_starttls_auto: true,
    ssl: true
  }
end

begin
  Mail.deliver do
    from     email_address
    to       email_address
    subject  'test subject'
    body 'test body'
  end
rescue StandardError => e
  puts "Failed to send email, with: #{e.to_s}"
  exit
end

puts "Mail sent successfully."