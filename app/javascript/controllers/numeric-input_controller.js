// https://github.com/stimulusjs/stimulus#-stimulus
import { Controller } from "stimulus"

export default class extends Controller {
  check(e) {
    const isMetaKey = e.metaKey;
    const isControlCharacter = e.charCode <= 31;
    const isDigit = e.charCode >= 48 && e.charCode <= 57;
    const isDot = e.charCode === 46;
    const isDotAllowed = !isDot || !e.target.value.includes('.');

    if (!isMetaKey && !isControlCharacter && !isDotAllowed && !isDigit) {
      e.preventDefault();
    }
  }
}
