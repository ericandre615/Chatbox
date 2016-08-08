'use strict';

import React from 'react';

const Message = React.createClass({
  propTypes: {
    updated_on: React.PropTypes.object,
    body: React.PropTypes.string
  },

  render() {
    return (
      <li className="message">
        { `[ ${this.props.updated_on} ] ${this.props.body}` }
      </li>
    );
  }
});

export default Message;
