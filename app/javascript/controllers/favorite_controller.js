import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["button"]

  connect() {
    console.log("fdasdf")
  }

  favorite(e) {
    e.preventDefault();

    fetch(this.data.get("url"), {
      method: 'POST',
      headers: {
        'X-CSRF-Token': document.querySelector("meta[name='csrf-token']").getAttribute("content"),
        'Content-Type': 'application/json',
        'Accept': 'application/json'
      }
    })
      .then(response => response.json())
      .then(data => {
        this.buttonTarget.style.color = data.favorited ? 'red' : '#af0d1d';
      });
  }
}
