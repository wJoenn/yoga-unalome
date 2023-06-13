import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["links"]

  toggleNavbar() {
    const navLinks = this.linksTarget
    navLinks.classList.toggle("active")
  }
}
