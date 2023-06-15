import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"


// Connects to data-controller="messenger-subscription"
export default class extends Controller {
  static values = { messengerId: Number }
  static targets = ["messages"]

  connect() {
    this.channel = createConsumer().subscriptions.create(
      { channel: "MessengerChannel", id: this.messengerIdValue },
      {
        received: data => {
          this.messagesTarget.insertAdjacentHTML("beforeend", data)
          this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
        }
      }
    );
    console.log(`Subscribed to the messenger with the id ${this.messengerIdValue}.`)
  };

  #insertMessageAndScrollDown(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
  }
  resetForm(event) {
    event.target.reset()
  }

  disconnect() {
    console.log("Unsubscribed from the messenger")
    this.channel.unsubscribe()
  }
}
