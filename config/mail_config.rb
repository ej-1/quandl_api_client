ActionMailer::Base.smtp_settings = {
  address:        'smtp.gmail.com',
  port:            587,
  user_name:      ENV['EMAIL'],
  password:       ENV['EMAIL_PASSWORD'],
  authentication: :login                 # :plain, :login or :cram_md5
}
