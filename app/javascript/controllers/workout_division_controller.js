import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['workoutSelect']

  submit() {
    this.element.requestSubmit();
  }
}
