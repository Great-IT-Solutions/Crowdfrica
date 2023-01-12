import {Controller} from "stimulus"

export default class extends Controller {

  openFacebookBox(e) {
    window.open(
      e.target.dataset.url,
      'facebook_share',
      'height=320, width=640, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no'
    );
  }

  openTwitterBox(e) {
    window.open(
      e.target.dataset.url,
      'twitter_share',
      'height=320, width=640, toolbar=no, menubar=no, scrollbars=no, resizable=no, location=no, directories=no, status=no');
  }

}
