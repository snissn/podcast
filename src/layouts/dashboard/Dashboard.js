import React, { Component } from 'react'
import UserHelper from '../../util/UserHelper'

class Dashboard extends Component {
  constructor(props, { authData }) {
    super(props)
    console.log(this);
    console.log(authData);
    authData = this.props
  }

  render() {
    return(
      <main className="container">
        <div className="pure-g">
          <div className="pure-u-1-1">
            <h1>Dashboard</h1>
            <p>Your name is: <strong>{this.props.authData.name}!</strong></p><p>Description:</p><p> {this.props.authData.description}</p>
          </div>
        </div>
      </main>
    )
  }
}

export default Dashboard
