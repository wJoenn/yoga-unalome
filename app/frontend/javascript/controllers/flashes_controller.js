import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flashes"
export default class extends Controller {
  async connect() {
    this.#showFlash()
    await this.#sleep(5000)
    this.hideFlash()
  }

  disconnect() {
    this.element.remove()
  }

  async hideFlash() {
    this.element.classList.add("invisible")
    await this.#sleep(350)
    this.element.remove()
  }

  async #showFlash() {
    await this.#sleep(10)
    this.element.classList.remove("invisible")
  }

  async #sleep(time) {
    await new Promise(resolve => { setTimeout(resolve, time) })
  }
}
