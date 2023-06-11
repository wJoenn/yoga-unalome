import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="booking-confirmation"
export default class extends Controller {
  static targets = ["booking", "card"]

  closeBookingConfirmation() {
    this.bookingTarget.innerHTML = ""
  }

  async showBookingConfirmation(event) {
    this.cardTargets.forEach(card => card.classList.remove("active"))
    event.currentTarget.classList.add("active")

    const id = event.currentTarget.dataset.id
    const html = await this.#fetchBookingConfirmationPartial(id)
    this.bookingTarget.innerHTML = html
  }

  async #fetchBookingConfirmationPartial(id) {
    const url = `events/${id}/confirmation`
    const res = await fetch(url)
    const data = await res.text()

    return data
  }
}
