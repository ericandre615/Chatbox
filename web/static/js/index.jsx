'use strict';

import React from 'react';
import ReactDOM from 'react-dom';
import Messages from './components/messages/messages.jsx';

const mountNode = document.getElementById('messages');

let messageData = [
  { updated_on: new Date(), body: 'body of message one'},
  { updated_on: new Date(), body: 'body of message twoone'},
  { updated_on: new Date(), body: 'body of message three'},
];

if(mountNode) {
  ReactDOM.render(<Messages messages={messageData} />, mountNode);
}
