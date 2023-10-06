import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["timecapField"];

  toggleTimecapField(event) {
    if (event.target.value === "Time") {
      this.timecapFieldTarget.classList.remove("hidden");
    } else {
      this.timecapFieldTarget.classList.add("hidden");
    }
  }
}
