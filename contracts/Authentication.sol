pragma solidity ^0.4.2;

import './zeppelin/lifecycle/Killable.sol';
contract Episode{
    bytes32 public ipfs;
    bytes32 public name;
    function Episode(bytes32 _ipfs, bytes32 _name){
        ipfs = _ipfs;
        name = _name;
    }
    function getname () constant returns (bytes32){
      return name;
    }
    function getipfs () constant returns (bytes32){
      return ipfs;
    }
}

contract Authentication is Killable {
  struct User {
    bytes32 name;   // short name (up to 32 bytes)
    bytes32 description;
    address[] episodes;
    uint numEpisodes;
  }
  event NewEpisodeEvent(bytes32 podcast_name, bytes32 description, bytes32 song_name, bytes32 song_ipfs, address sender);

  mapping (address => User) private users;
  mapping (address => Episode) private episodes;

  uint private id; // Stores user id temporarily

  function getNumEpisodes() constant returns  (uint){
    return  users[msg.sender].numEpisodes;
  }

  function getUserEpisode(uint index) constant returns  (bytes32, bytes32 ){
    Episode episode =   episodes[users[msg.sender].episodes[index]];
    return ( episode.getname(), episode.getipfs());
  }
  function create_episode(bytes32 name, bytes32 ipfs)  returns (bool){
      Episode new_episode = new Episode({_ipfs:ipfs,_name: name});
      episodes[address(new_episode)] = new_episode; 
      users[msg.sender].episodes.push(new_episode);
      User user = users[msg.sender];
      user.numEpisodes += 1;
      NewEpisodeEvent(user.name, user.description, name, ipfs, msg.sender);
      return true;
  }


  function getName () constant returns (bytes32) {
    return users[msg.sender].name;
  }

  function getDescription () constant returns (bytes32) {
    return users[msg.sender].description;
  }
  function login() constant returns (bytes32, bytes32) {
    // Check if user exists.
    // If yes, return user.
    // If no, throw.
    assert( !(users[msg.sender].name == 0x0));
    return ( users[msg.sender].name, users[msg.sender].description);
  }

  function signup(bytes32 name, bytes32 description) payable returns (bytes32, bytes32) {
    // Check if user exists.
    // If yes, return user name.
    // If no, check if name was sent.
    // If yes, create and return user.
    // If no, throw.

    assert(! (name == 0x0));
    users[msg.sender].description = description;
    users[msg.sender].numEpisodes = 0;
    create_episode("first single", "url");

    if (users[msg.sender].name == 0x0)
    {
        users[msg.sender].name = name;

        return (users[msg.sender].name, description);
    }

    return (users[msg.sender].name, description);
  }

  function update(bytes32 name, bytes32 description) payable returns (bytes32, bytes32) {
    // Update user name.
    assert(! (name == 0x0));
    if (users[msg.sender].name != 0x0)
    {
        users[msg.sender].name = name;

        return (users[msg.sender].name, users[msg.sender].description);
    }

  }
}
