pragma solidity ^0.4.2;

import './zeppelin/lifecycle/Killable.sol';
/*
contract Episode{
  //todo include block number of release

    string public ipfs;
    string public name;
    function Episode(string _ipfs, string _name){
        ipfs = _ipfs;
        name = _name;
    }
}
*/

contract Authentication is Killable {
  struct Episode{
    string ipfs;
    string name;
  }
  struct User {
    bytes32 name;   // short name (up to 32 bytes)
    string description;
    Episode[] episodes;
    uint numEpisodes;
  }
  event NewEpisodeEvent(bytes32 podcast_name, string description, string song_name, string song_ipfs, address sender);

  mapping (address => User) private users;

  uint private id; // Stores user id temporarily

  function getNumEpisodes() constant returns  (uint){
    return  users[msg.sender].numEpisodes;
  }

  function getUserEpisode(uint index) constant returns  (address ){
    //return ("hi", "bye");
    return msg.sender;
    //Episode episode =   users[msg.sender].episodes[index];
    //return ( episode.name, episode.ipfs);
  }
  function create_episode(string name, string ipfs)  returns (bool){
      //songs_mapping[msg.sender].push(Episode({ipfs:ipfs, name:name}));

      Episode memory episode = Episode(ipfs,name);
      users[msg.sender].episodes.push(episode);

      User user = users[msg.sender];
      user.numEpisodes += 1;
      NewEpisodeEvent(user.name, user.description, name, ipfs, msg.sender);
      return true;
  }


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
    users[msg.sender].numEpisodes = 1;
    create_episode("first single", "url");

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
