// https://github.com/stimulusjs/stimulus#-stimulus
import { Controller } from "stimulus"

export default class extends Controller {

  show(e) {
    e.preventDefault();
    jQuery(e.target).tab('show');
  }

}
