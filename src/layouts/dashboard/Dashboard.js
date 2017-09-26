import React, { Component } from 'react'
var toascii = function (t){var e="",n=0,r=t.length;for("0x"===t.substring(0,2)&&(n=2);n<r;n+=2){var o=parseInt(t.substr(n,2),16);e+=String.fromCharCode(o)}return e}

class Dashboard extends Component {
  constructor(props, { authData }) {
    super(props)
    console.log('this');
    console.log(this);
    console.log(authData);
    authData = this.props
    //authData.props.user.data.description = toascii(authData.props.user.data.description)
  }

  render() {
    return(
      <main className="container">
        <div className="pure-g">
          <div className="pure-u-1-1">
            <h1>Dashboard</h1>
            <p>Your name is: <strong>{this.props.authData.name}!</strong></p><p>Description:</p><p> {toascii(this.props.authData.description)}</p>
          </div>
        </div>
      </main>
    )
  }
}

export default Dashboard
