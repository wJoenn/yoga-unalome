class StripeCheckoutSessionService
  def call(event)
    checkout_session = event.data.object

    booking = Booking.find_by(checkout_session_id: checkout_session.id)
    booking.update(status: "confirmed")

    create_transaction(evebt, checkout_session)
  end

  private

  def create_transaction
    recipient = User.find(checkout_session.metadata.recipient_id.to_s)
    payer = User.find_by(email: checkout_session.customer_details.email)
    amount_cents = checkout_session.amount_total
    amount_net_cents = amount_net(amount_cents)
    communication = "Payment done the #{Time.zone.at(event.created)}"

    Transaction.create(
      recipient:,
      recipient_name: recipient.full_name,
      payer:,
      payer_name: payer.full_name,
      amount_cents:,
      amount_net_cents:,
      communication:
    )
  end

  def amount_net(amount_cents)
    payment_intent = Stripe::PaymentIntent.retrieve({
      id: checkout_session.payment_intent,
      expand: ["ltest_charge.balance_transaction"]
    })

    fee_cents = payment_intent.latest_charge.balance_transaction.fee
    amount_cents - fee_cents
  end
end

# p event =>
# <Stripe::Event:0x7490 id=evt_1NG309Ezdt39ObMZQCjGkxvF> JSON: {
#   "id": "evt_1NG309Ezdt39ObMZQCjGkxvF",
#   "object": "event",
#   "api_version": "2022-11-15",
#   "created": 1686069897,
#   "data": {
#     "object": {
#       "id": "cs_test_a1mlFxChz4IMjGfpD1kSSTJkTKaRXbBAvRuGYtbe6bwsA53ysGvMFTyu7v",
#       "object": "checkout.session",
#       "after_expiration": null,
#       "allow_promotion_codes": null,
#       "amount_subtotal": 1200,
#       "amount_total": 1200,
#       "automatic_tax": {
#         "enabled": false,
#         "status": null
#       },
#       "billing_address_collection": null,
#       "cancel_url": "https://102d-82-212-158-216.ngrok-free.app/bookings/payment_canceled",
#       "client_reference_id": null,
#       "consent": null,
#       "consent_collection": null,
#       "created": 1686072273,
#       "currency": "eur",
#       "currency_conversion": null,
#       "custom_fields": [],
#       "custom_text": {
#         "shipping_address": null,
#         "submit": null
#       },
#       "customer": "cus_O27sNQ11ciZVUC",
#       "customer_creation": null,
#       "customer_details": {
#         "address": {
#           "city": null,
#           "country": "BE",
#           "line1": null,
#           "line2": null,
#           "postal_code": null,
#           "state": null
#         },
#         "email": "user@example.com",
#         "name": "User Example",
#         "phone": null,
#         "tax_exempt": "none",
#         "tax_ids": []
#       },
#       "customer_email": null,
#       "expires_at": 1686158673,
#       "invoice": null,
#       "invoice_creation": {
#         "enabled": false,
#         "invoice_data": {
#           "account_tax_ids": null,
#           "custom_fields": null,
#           "description": null,
#           "footer": null,
#           "metadata": {},
#           "rendering_options": null
#         }
#       },
#       "livemode": false,
#       "locale": null,
#       "metadata": {
#         "recipient_id": "1"
#       },
#       "mode": "payment",
#       "payment_intent": "pi_3NG3cgEzdt39ObMZ0SfgrKAj",
#       "payment_link": null,
#       "payment_method_collection": "always",
#       "payment_method_options": {},
#       "payment_method_types": ["card"],
#       "payment_status": "paid",
#       "phone_number_collection": {
#         "enabled": false
#       },
#       "recovered_from": null,
#       "setup_intent": null,
#       "shipping_address_collection": null,
#       "shipping_cost": null,
#       "shipping_details": null,
#       "shipping_options": [],
#       "status": "complete",
#       "submit_type": null,
#       "subscription": null,
#       "success_url": "https://102d-82-212-158-216.ngrok-free.app/bookings/payment_successful",
#       "total_details": {
#         "amount_discount": 0,
#         "amount_shipping": 0,
#         "amount_tax": 0
#       },
#       "url": null
#     }
#   },
#   "livemode": false,
#   "pending_webhooks": 1,
#   "request": {"id":null,"idempotency_key":null},
#   "type": "checkout.session.completed"
# }
