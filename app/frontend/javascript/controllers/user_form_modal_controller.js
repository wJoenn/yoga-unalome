import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-form-modal"
export default class extends Controller {
  static targets = ["modal", "form"]

  hideForm(event) {
    if (event.target === event.currentTarget) {
      this.modalTarget.classList.add("hidden")
      this.formTargets[0].classList.remove("hidden")
      this.formTargets[1].classList.add("hidden")
    }
  }

  toggleForm() {
    this.formTargets.forEach(form => form.classList.toggle("hidden"))
  }

  showForm() {
    this.modalTarget.classList.remove("hidden")
  }
}
