import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="toggle-hidden-password"
export default class extends Controller {
  static targets = ["input"]

  togglePassword(event) {
    const button = event.currentTarget
    this.inputTarget.type = button.classList.contains("fa-eye") ? "text" : "password"

    button.classList.toggle("fa-eye")
    button.classList.toggle("fa-eye-slash")
  }
}
