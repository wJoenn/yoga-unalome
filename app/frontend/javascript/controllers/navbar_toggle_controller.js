import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["button", "links"]

  connect() {
    console.log("This is navbar_controller")
  }

  // toggleNavbar() {
  //   const toggleButton = document.getElementsByClassName("toggle-button")[0]
  //   const navbarLinks = document.getElementsByClassName("navbar-links")[0]

  //   toggleButton.addEventListener("click", () => {
  //     navbarLinks.classList.toggle("active")
  //   })
  // }
}
