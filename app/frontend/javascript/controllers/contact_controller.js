import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["popup"];

  showForm(event) {
    event.preventDefault();
    console.log("showForm called");
    console.log(`Popup target in showForm: ${this.popupTarget}`);
    this.popupTarget.style.display = "block";
  }

  hideForm(event) {
    event.preventDefault();
    console.log("hideForm called");
    console.log(`Popup target in hideForm: ${this.popupTarget}`);
    this.popupTarget.style.display = "none";
  }
}
