import { Controller } from '@hotwired/stimulus';

export default class extends Controller {
  static targets = ['workoutSelect']

  submit(event) {
    this.element.requestSubmit();
    console.log(this.workoutSelectTarget.value);
    this.workoutSelectTarget.value = `${this.workoutSelectTarget.value}`;
  }
}
