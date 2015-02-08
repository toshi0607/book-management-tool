module Constants
  if Rails.env.production? || Rails.env.staging?
    CA_FILE = '/usr/lib/ssl/certs/ca-certificates.crt'
  else
    CA_FILE = 'tmp/cacert.pem'
  end
end