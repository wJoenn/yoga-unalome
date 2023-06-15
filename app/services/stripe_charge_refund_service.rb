class StripeChargeRefundService
  def call(event)
    charge = event.data.object
    checkout_session = checkout_session(charge.payment_intent)

    booking = Booking.find_by(checkout_session_id: checkout_session.id)
    booking.update(status: "refunded")

    create_transaction(event, charge)
  end

  private

  def checkout_session(payment_intent_id)
    checkout_sessions = Stripe::Checkout::Session.list(payment_intent: payment_intent_id)
    checkout_sessions.data.first
  end

  def create_transaction(event, charge)
    recipient = User.find_by(email: charge.billing_details.email)
    payer = User.find_by(admin: true)
    amount_cents = charge.amount_refunded
    amount_net_cents = charge.amount_refunded
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
end

# <Stripe::Event:0x8084 id=evt_3NIYRWEzdt39ObMZ0TB54nk9> JSON: {
#   id: "evt_3NIYRWEzdt39ObMZ0TB54nk9",
#   object: "event",
#   api_version: "2022-11-15",
#   created: 1686667430,
#   data: {
#     object: {
#       id: "ch_3NIYRWEzdt39ObMZ0xjizLfP",
#       object: "charge",
#       amount: 1200,
#       amount_captured: 1200,
#       amount_refunded: 1200,
#       application: null,
#       application_fee: null,
#       application_fee_amount: null,
#       balance_transaction: "txn_3NIYRWEzdt39ObMZ0ij7xKH9",
#       billing_details: {
#         address: {
#           city: null,
#           country: "BE",
#           line1: null,
#           line2: null,
#           postal_code: null,
#           state: null
#         },
#         email: "user@example.com",
#         name: "user",
#         phone: null
#       },
#       calculated_statement_descriptor: "CHLOE | YOGA UNALOME",
#       captured: true,
#       created: 1686667415,
#       currency: "eur",
#       customer: "cus_O4hrbvJssMIl5Z",
#       description: null,
#       destination: null,
#       dispute: null,
#       disputed: false,
#       failure_balance_transaction: null,
#       failure_code: null,
#       failure_message: null,
#       fraud_details: {},
#       invoice: null,
#       livemode: false,
#       metadata: {},
#       on_behalf_of: null,
#       order: null,
#       outcome: {
#         network_status: "approved_by_network",
#         reason: null,
#         risk_level: "normal",
#         risk_score: 36,
#         seller_message: "Payment complete.",
#         type: "authorized"
#       },
#       paid: true,
#       payment_intent: "pi_3NIYRWEzdt39ObMZ0dt7rDOd",
#       payment_method: "pm_1NIYRWEzdt39ObMZ372UgaAY",
#       payment_method_details: {
#         card: {
#           brand: "visa",
#           checks: {
#             address_line1_check: null,
#             address_postal_code_check: null,
#             cvc_check: "pass"
#           },
#           country: "US",
#           exp_month: 12,
#           exp_year: 2034,
#           fingerprint: "5GlNHdMR2UEMgB4j",
#           funding: "credit",
#           installments: null,
#           last4: "4242",
#           mandate: null,
#           network: "visa",
#           network_token: { used: false },
#           three_d_secure: null,
#           wallet: null
#         },
#         type: "card"
#       },
#       receipt_email: "user@example.com",
#       receipt_number: null,
#       receipt_url: "https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xTkQzbHFFemR0MzlPYk1aKKaBoqQGMgbaiGwlo1Q6LBaVvt9DiEf_0aQybgeWPmK6xRYdd0eaS8YSlhufhvWpx5JpswPZOhGtZ8j6",
#       refunded: true,
#       review: null,
#       shipping: null,
#       source: null,
#       source_transfer: null,
#       statement_descriptor: null,
#       statement_descriptor_suffix: null,
#       status: "succeeded",
#       transfer_data: null,
#       transfer_group: null
#     },
#     previous_attributes: {
#       amount_refunded: 0,
#       receipt_url: "https://pay.stripe.com/receipts/payment/CAcaFwoVYWNjdF8xTkQzbHFFemR0MzlPYk1aKKWBoqQGMgaiT9eOmrs6LBZAC8Mz0KpN8FuSc3yIFthBmX9ZrFcwOGuv2NESy5Kr3WNmpOnCC9JF1UdL",
#       refunded: false
#     }
#   },
#   livemode:  false,
#   pending_webhooks:  1,
#   request: {
#     id:"req_nrPibDTNLT8R3g",
#     idempotency_key:"8fd403bb-bb94-40dc-bb9f-a9a906b64f49"
#   },
#   type: "charge.refunded"
# }
