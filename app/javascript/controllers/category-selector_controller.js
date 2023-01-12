import {Controller} from "stimulus"

export default class extends Controller {

  static targets = ['container']

  toggle(e) {
    this.containerTargets.forEach(container => {
      if (container.dataset.categoryId === e.target.value) {
        container.classList.remove('hide')
        container.classList.add('show')
      } else {
        container.classList.remove('show')
        container.classList.add('hide')
      }
    })
  }

}
