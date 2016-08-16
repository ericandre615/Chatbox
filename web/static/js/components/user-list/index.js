'use strict';

import React from 'react';
import ListItem from './list-item.jsx';

const UserList = React.createClass({
  getUserList() {
    if('sessionStorage' in window) {
      let user_list = sessionStorage.getItem('users');
      if(user_list) {
        return JSON.parse(user_list);
      } else {
        return null;
      }
    }
  },

  render(){
    let userList = this.getUserList();
    console.log('USERS: ', userList);
    let users = this.getUserList().map(user => {
      return (
        <ListItem user={user} key={user.id} />
      );
    });

    return(
      <ul id="user-list">
        { users }
      </ul>
    );
  }
});

export default UserList;
