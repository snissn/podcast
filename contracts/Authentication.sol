pragma solidity ^0.4.2;

import './zeppelin/lifecycle/Killable.sol';

contract Song{

    string ipfs;
    string name;
    address artist;
    function Song(string _ipfs, string _name, address _artist){
        ipfs = _ipfs;
        name = _name;
        artist = _artist;
    }
}

contract Album{

    Song[]  songs;
    string public name;
    address artist;
    function Album(string _name){
        name = _name;
    }
    function add_song(Song song){
        songs.push(song);
    }
}

contract Authentication is Killable {
  struct User {
    bytes32 name;   // short name (up to 32 bytes)
    string description;
    address[] albums;
    address[] singles;
  }

  mapping (address => User) private users;

  uint private id; // Stores user id temporarily

  function login() constant returns (bytes32, string) {
    // Check if user exists.
    // If yes, return user.
    // If no, throw.

    assert( !(users[msg.sender].name == 0x0));

    return (users[msg.sender].name, users[msg.sender].description);
  }

  function signup(bytes32 name, string description) payable returns (bytes32, string) {
    // Check if user exists.
    // If yes, return user name.
    // If no, check if name was sent.
    // If yes, create and return user.
    // If no, throw.

    assert(! (name == 0x0));
    users[msg.sender].description = description;

    if (users[msg.sender].name == 0x0)
    {
        users[msg.sender].name = name;

        return (users[msg.sender].name, description);
    }

    return (users[msg.sender].name, description);
  }

  function update(bytes32 name, string description) payable returns (bytes32, string) {
    // Update user name.
    assert(! (name == 0x0));
    if (users[msg.sender].name != 0x0)
    {
        users[msg.sender].name = name;

        return (users[msg.sender].name, users[msg.sender].description);
    }

  }
}
