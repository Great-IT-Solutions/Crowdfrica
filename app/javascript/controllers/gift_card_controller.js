// https://github.com/stimulusjs/stimulus#-stimulus
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "form" ]

  toggle() {
    if (this.formTarget.style.display === 'none') {
      this.formTarget.style.display = 'block';
    } else {
      this.formTarget.style.display = 'none';
    }
  }
}
