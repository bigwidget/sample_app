ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "localhost:3000"

ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'gmail.com',
  :user_name            => 'tim.koelkebeck@gmail.com',
  :password             => 'k0k0puff',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}