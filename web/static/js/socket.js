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

  channel.on('user_joined', payload => {
    let users = JSON.parse(sessionStorage.getItem('users')) || [];

    let users_ids = users.map(user => user.id ); 

    if(users_ids.indexOf(payload.user_id) == -1) {
      users.push({
       "id": payload.user_id,
       "username": payload.username,
       "email": payload.email
      });
    }
    sessionStorage.setItem('users', JSON.stringify(users));
    console.log(`user[${payload.user_id}]  ${payload.username} has joined`);
  });

  channel.on('user_left', payload => {
    let users = JSON.parse(sessionStorage.getItem('users'));
    if(users) {
      let users_ids = users.map(user => user.id ); 
      let userIndex = users_ids.indexOf(payload.user_id);

      if(users_ids.indexOf(payload.user_id) >= 0) {
        console.log(`userindex: ${userIndex}`);
        delete users[userIndex];
      }
      sessionStorage.setItem('users', JSON.stringify(users));
      console.log(`user[${payload.user_id}]  ${payload.username} has left`);
    }
  });

  channel.on('presence_state', payload => {
    console.log('Presence State Rec: ', payload);
    let user_ids = Array.from(Object.keys(payload));
    console.log('USERIDs, ', user_ids);
  });

  channel.on('presence_diff', payload => {
    console.log('Pres DIFF ', payload);
  });

  channel.join()
    .receive("ok", resp => { console.log("Joined successfully", resp) })
    .receive("error", resp => { console.log("Unable to join", resp) })
}
  export default socket
