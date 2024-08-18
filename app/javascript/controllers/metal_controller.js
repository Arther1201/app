import { Controller } from "stimulus";

export default class extends Controller {
  update(event) {
    this.element.closest("form").requestSubmit();
  }
}