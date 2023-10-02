import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    // Check the screen size when the controller is connected
    this.checkScreenSize();

    // Add a resize event listener to check screen size changes
    window.addEventListener('resize', this.checkScreenSize.bind(this));
  }

  checkScreenSize() {
    // Get the current window width
    const windowWidth = window.innerWidth;

    // Define the screen size threshold for enabling the controller
    const screenSizeThreshold = 768; // For example, 768 pixels for mobile view

    if (windowWidth <= screenSizeThreshold) {
      // Enable the controller and add the toggle listener
      this.isActive = true;
    } else if (windowWidth > screenSizeThreshold) {
      // Disable the controller and remove the toggle listener
      this.isActive = false;
    }
  }


  toggle() {
    if (this.isActive) {
      let elementId = `${this.element.id}_details`
      let athleteDetails = document.getElementById(elementId)
  
      let isClose = athleteDetails.classList.contains('max-h-0')
      isClose ? this.show(athleteDetails) : this.hide(athleteDetails)
    }
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
