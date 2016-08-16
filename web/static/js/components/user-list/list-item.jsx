'use strict';

import React from 'react';

const ListItem = React.createClass({
  propTypes: {
    user: React.PropTypes.object
  },

  render() {
    return (
      <li className="user-list-item">
        <p>{ this.props.user.username } | { this.props.user.email }</p>
      </li>
    );
  }
});

export default ListItem;
