pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Authentication.sol";

contract TestAuthentication {

  function testItStoresAValue() {
    Authentication auth = Authentication(DeployedAddresses.Authentication());
    bytes32 user = "user";
    bytes32 description = "description";
    auth.signup(user, description);
    Assert.equal(auth.getName(), user, "It should store the username.");
    Assert.equal(auth.getDescription(), description, "It should store the description.");

    uint expected_episodes = 1;
    Assert.equal(auth.getNumEpisodes(), expected_episodes, "Problem with episode count");
    bytes32  episode_name;
    bytes32 episode_ipfs;
    bytes32 expected_episode_name = "first single";
    bytes32 expected_ipfs = "url";


    (episode_name, episode_ipfs )= auth.getUserEpisode(0);
    Assert.equal(episode_name, expected_episode_name, "Problem with episode name");
    Assert.equal(episode_ipfs, expected_ipfs, "Problem with episode ipfs");

  }

}
