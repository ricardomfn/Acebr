import { Controller } from "@hotwired/stimulus"
import Swal from 'sweetalert2';

// Connects to data-controller="popup"
export default class extends Controller {
  connect() {
    console.log("hello")
  }

  handleClick() {
    Swal.fire({
      title: 'Seu oponente foi notificado, agora ele deve aceitar o desafio!',
      width: 500,
      padding: '3em',
      color: '#253343',
      backdrop: `
        rgba(0,0,123,0.4)
        url("https://www.informatiquegifs.com/gifs/images/tennis/1.gif")
        bottom
        no-repeat
      `
    });
  }
}
