class ContactMailer < ApplicationMailer
  def contact_email(contact)
    @contact = contact
    mail(to: 'form@example.com', subject: 'New Contact Message') #subject will be later subject of e-mail which is send.
  end
end
