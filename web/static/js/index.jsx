'use strict';

import React from 'react';
import ReactDOM from 'react-dom';
import Messages from './components/messages';
import UserList from './components/user-list';

const mountNode = document.getElementById('messages');
const userNode = document.getElementById('sidebar');

let messageData = [
  { updated_on: new Date(), body: 'body of message one'},
  { updated_on: new Date(), body: 'body of message twoone'},
  { updated_on: new Date(), body: 'body of message three'},
];

if(mountNode) {
  ReactDOM.render(<Messages messages={messageData} />, mountNode);
}

if(userNode) {
  ReactDOM.render(<UserList />, userNode);
}
