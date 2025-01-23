import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="application"
export default class extends Controller {
  connect() {
    // console.log("running on 3000")
    $("#notice-id").fadeOut( 2000 );
    $("#alert-id").fadeOut( 2000 );
  }
}
