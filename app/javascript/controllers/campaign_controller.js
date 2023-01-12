// https://github.com/stimulusjs/stimulus#-stimulus
import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "amountInput" ]

  setAmount(e) {
    this.amountInputTarget.value = e.target.dataset.amount;
    this.amountInputTarget.dispatchEvent(new Event('input'));
  }

  redirectToDonation(e) {
    const amount = parseFloat(this.amountInputTarget.value);

    if (isNaN(amount) || amount < 2) {
      jQuery(e.target).popover();
    } else {
      window.open(this.data.get("donationUrl") + "?amount=" + amount, "_self")
    }
  }
}
