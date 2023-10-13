import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['iconDown', 'iconUp'];


  toggle() {
    let elementId = `${this.element.id}_details`
    let athleteDetails = document.getElementById(elementId)

    let isClose = athleteDetails.classList.contains('max-h-0')
    isClose ? this.show(athleteDetails) : this.hide(athleteDetails)

    const iconDown = this.iconDownTarget;
    const iconUp = this.iconUpTarget;

    iconDown.classList.toggle('hidden');
    iconUp.classList.toggle('hidden');
  }

  show(athleteDetails) {
    athleteDetails.classList.add('max-h-96')
    athleteDetails.classList.remove('max-h-0')
  }

  hide(athleteDetails) {
    athleteDetails.classList.add('max-h-0')
    athleteDetails.classList.remove('max-h-96')
  }
}
