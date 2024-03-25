import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "preview"]

  preview() {
    let input = this.inputTarget.files[0];
    let preview = this.previewTarget;

    if (input) {
      let reader = new FileReader();

      reader.onload = (event) => {
        preview.src = event.target.result;
      };

      reader.readAsDataURL(input);
    } else {
      preview.src = "";
    }
  }
}