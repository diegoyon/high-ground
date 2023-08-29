import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "menu", "hamburger", "close" ]
  static values = { isOpen: { type: Boolean, default: false }}

  menu() {
    this.isOpenValue ? this.hide() : this.show()
    this.isOpenValue = !this.isOpenValue
  }

  show() {
    this.menuTarget.classList.remove('max-h-0', 'opacity-0')
    this.menuTarget.classList.add('max-h-none', 'opacity-100')
    this.hamburgerTarget.classList.add('hidden')
    this.closeTarget.classList.remove('hidden')
  }

  hide() {
    this.menuTarget.classList.add('max-h-0', 'opacity-0')
    this.menuTarget.classList.remove('max-h-none', 'opacity-100')
    this.hamburgerTarget.classList.remove('hidden')
    this.closeTarget.classList.add('hidden')
  }
}