'use strict';
// NOTE: The contents of this file will only be executed if
// you uncomment its entry in "web/static/js/app.js".

// To use Phoenix channels, the first step is to import Socket
// and connect at the socket path in "lib/my_app/endpoint.ex":
import {Socket} from "phoenix"

const socket = new Socket("/socket", {params: {token: window.userToken}})
const guardianTokenContainer = document.querySelector('meta[name="guardian_token"]');

if(guardianTokenContainer) {

  const guardian_token = guardianTokenContainer.getAttribute('content');

  socket.connect()
  // Now that you are connected, you can join channels with a topic:
  let channel = socket.channel("room:lobby", {token: guardian_token, guardian_token: guardian_token});
  let chatInput = document.getElementById('chat-input');
  let chatForm = document.querySelector('form[name="chat-form"]');
  let messagesContainer = document.getElementById('messages-box');

  if(chatInput) {
    chatForm.addEventListener('submit', event => {
      event.preventDefault();
      console.log(`chat_msg ${chatInput.value}`);
      channel.push('new_msg', {body: chatInput.value});
      chatInput.value = '';

    }, false);
  }

  channel.on('new_msg', payload => {
    let messageElement = document.createElement('p');

    console.log(`Message Received: ${payload.body}`);
    
    messageElement.innerHTML = `[${ new Date() }]: ${payload.email}:  ${payload.body}`;
    messagesContainer.appendChild(messageElement);
  });

  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
}
  export default socket
