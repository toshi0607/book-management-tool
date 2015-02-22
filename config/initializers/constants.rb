module Constants
  # RAKUTEN_API = "/services/api/BooksBook/Search/20130522"
  # AP_ID = '1062746000989149114'
  if Rails.env.production? || Rails.env.staging?
    CA_FILE = '/usr/lib/ssl/certs/ca-certificates.crt'
  else
    CA_FILE = 'tmp/cacert.pem'
  end
end