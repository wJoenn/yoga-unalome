class ContactsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create]

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      ContactMailer.contact_email(@contact).deliver_now
      flash[:notice] = "Thank you for your message. We will get back to you soon!" #could be replaced by  I18n placeholderh
      redirect_to root_path
    else
      flash[:error] = "An error occurred while delivering this message." #see above.
      render :new
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
