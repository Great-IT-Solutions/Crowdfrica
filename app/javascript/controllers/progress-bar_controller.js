import {Controller} from "stimulus"

export default class extends Controller {

  static targets = ['progressBar']

  connect() {
    this.updateProgressBar()
  }

  update(e) {
    let newValue;
    if (e.target.value === '') {
      newValue = 0;
    } else {
      newValue = parseFloat(e.target.value);
    }

    this.progress = this.calculateProgress(this.currentValue + newValue, this.expectedValue);
  }

  updateProgressBar() {
    if (this.progress >= 100) {
      this.progressBarTarget.classList.remove('progress-bar-warning');
      this.progressBarTarget.classList.add('progress-bar-success');
      this.progressBarTarget.style.width = '100%';
    } else {
      this.progressBarTarget.classList.remove('progress-bar-success');
      this.progressBarTarget.classList.add('progress-bar-warning');
      this.progressBarTarget.style.width = `${this.progress}%`;
    }
  }

  calculateProgress(currentValue, expectedValue) {
    if (expectedValue === 0) return 0;

    const progress = (currentValue / expectedValue) * 100;

    return Math.min(100, progress);
  }

  get progress() {
    return parseFloat(this.data.get("progress"))
  }

  set progress(value) {
    this.data.set("progress", value)
    this.updateProgressBar()
  }

  get currentValue() {
    return parseFloat(this.data.get("currentValue"))
  }

  get expectedValue() {
    return parseFloat(this.data.get("expectedValue"))
  }

}
