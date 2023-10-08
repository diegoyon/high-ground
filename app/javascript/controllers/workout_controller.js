import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["workoutTypeSelect", "timecapField"];

  connect() {
    this.toggleTimecapField();
  }

  toggleTimecapField() {
    if (this.workoutTypeSelectTarget.value === "Time") {
      this.timecapFieldTarget.classList.remove("hidden");
    } else {
      this.timecapFieldTarget.classList.add("hidden");
    }
  }
}
