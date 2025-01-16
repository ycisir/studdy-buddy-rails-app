import consumer from "channels/consumer"

document.addEventListener('turbo:load', () => {
  const room_element = document.getElementById('room-id')
  if(room_element) {

    consumer.subscriptions.subscriptions.forEach((subscription) => {
      consumer.subscriptions.remove(subscription)
    })

    const room_id = room_element.getAttribute('data-room-id')

    consumer.subscriptions.create({ channel: "RoomChannel", room_id: room_id }, {

      connected() {
        // Called when the subscription is ready for use on the server
        console.log("connected with room: " + room_id)
      },

      disconnected() {
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        // Called when there's incoming data on the websocket for this channel
        // console.log(data)
        let html;
        const messageContainer = document.getElementById('messages')
        messageContainer.innerHTML = messageContainer.innerHTML + data.html

        html = data.html
        var chatBox = document.getElementById('message_body')
        var mediaBox = document.getElementById('message_media_file')
        chatBox.value = ''
        mediaBox.value = ''
      }
    });  
  }
})



