// https://github.com/stimulusjs/stimulus#-stimulus
import { Controller } from "stimulus"

export default class extends Controller {

  static targets = ["radioButton", "form"]

  connect() {
    this.radioButtonTargets.forEach(radioButton => {
      if (radioButton.checked) {
        const form = this.formTargets.find(form => form.id === radioButton.dataset.formId);
        form.style.display = 'block';
      }
    });
  }

  select(e) {
    this.formTargets.forEach(form => {
      if (form.id === e.target.dataset.formId) {
        form.style.display = 'block';
      } else {
        form.style.display = 'none';
      }
    });
  }
}
