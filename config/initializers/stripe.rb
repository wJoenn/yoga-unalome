require_relative "../../app/services/stripe_checkout_session_service"

Rails.configuration.stripe = {
  publishable_key: Rails.application.credentials.stripe.publishable_key,
  secret_key: Rails.application.credentials.stripe.secret_key,
  signing_secret: Rails.application.credentials.stripe.webhook_secret_key
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]
StripeEvent.signing_secret = Rails.configuration.stripe[:signing_secret]

StripeEvent.configure do |events|
  events.subscribe "checkout.session.completed", StripeCheckoutSessionService.new
end
