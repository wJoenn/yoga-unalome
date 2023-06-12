module MailerHelper
  def email_image_tag(image, **options)
    attachments[image] = Rails.root.join("app/frontend/#{image}").read
    image_tag attachments[image].url, **options
  end
end
