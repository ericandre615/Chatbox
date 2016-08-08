'use strict';

import React from 'react';
import Message from './message.jsx';

const Messages = React.createClass({
  propTypes: {
    messages: React.PropTypes.arrayOf(React.PropTypes.object)
  },

  render() {
    let messages = this.props.messages.map((msg, i) => {
      console.log(msg);
      return (
        <Message
          updated_on={ msg.updated_on }
          body={ msg.body }
          key={ i } 
        />
      );
    });

    return (
      <ul id="messages-container">
        <li>ChattieMessages</li>
        { messages }
      </ul>
    );
  }
});

export default Messages;
