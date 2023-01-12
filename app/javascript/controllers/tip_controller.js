// https://github.com/stimulusjs/stimulus#-stimulus
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ 'amount', 'radio', 'customRadio', 'customInput', 'hiddenInput' ]

  connect() {
    this.updateValues();
  }

  updateValues() {
    this.radioTargets.forEach(radio => {
      const percentage = parseFloat(radio.dataset.percentage);
      if (isNaN(percentage)) { return; }

      const label = document.querySelector(`label[for=${radio.id}]`);
      const amount = parseFloat(this.amountTarget.value) || 0.0;
      const tip = percentage * amount / 100;

      radio.value = tip;
      label.innerHTML = `$ ${tip}`;
    });
  }

  toggleCustomInput(e) {
    if (e.target === this.customRadioTarget) {
      this.customInputTarget.style.display = 'block';
      this.hiddenInputTarget.value = 0;
    } else {
      this.customInputTarget.style.display = 'none';
      this.customInputTarget.value = '';
    }
  }

  updateHiddenInput(e) {
    this.hiddenInputTarget.value = e.target.value;
  }
}
