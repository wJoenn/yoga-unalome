import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-form-modal"
export default class extends Controller {
  static targets = ["modal"]

  hideForm(event) {
    if (event.target === event.currentTarget) {
      this.modalTarget.classList.remove("visible")
    }
  }

  showForm() {
    this.modalTarget.classList.add("visible")
  }
}
