import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-form-modal"
export default class extends Controller {
  static targets = ["modal", "form"]

  static values = {
    locale: String
  }

  connect() {
    window.addEventListener("keyup", event => {
      if (event.key === "Escape") window.location.href = "/"
    })
  }

  hideForm(event) {
    if (event.target === event.currentTarget) {
      window.location.href = `/${this.localeValue}`
    }
  }
}
