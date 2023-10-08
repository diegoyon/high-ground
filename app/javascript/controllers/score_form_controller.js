import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["cappedField", "mainScoreField", "mainScoreCappedField"]

  connect() {
    if (this.hasCappedFieldTarget) {
      this.toggleMainScoreField();
    }
  }

  toggleMainScoreField() {
    if (this.cappedFieldTarget.checked) {
      this.mainScoreFieldTarget.classList.add("hidden");
      this.mainScoreCappedFieldTarget.classList.remove("hidden");
    } else {
      this.mainScoreFieldTarget.classList.remove("hidden");
      this.mainScoreCappedFieldTarget.classList.add("hidden");
    }
  }
}
