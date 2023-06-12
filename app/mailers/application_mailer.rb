class ApplicationMailer < ActionMailer::Base
  helper MailerHelper
  default from: "Chloé | Yoga Unalome <info@yogaunalome.com>"
  layout "mailer"
end
