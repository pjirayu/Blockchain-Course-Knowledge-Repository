// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.6/VRFConsumerBase.sol";
import "https://github.com/smartcontractkit/chainlink/blob/master/evm-contracts/src/v0.6/Owned.sol";
/**
* PLEASE DO NOT USE THIS CODE IN PRODUCTION.
*/
contract RandomNumberConsumer is VRFConsumerBase {
    bytes32 internal keyHash;
    uint256 internal fee;
    bytes32 public reqId;
    uint256 public randomResult;
    event RandomNumberReceived(bytes32 indexed requestId, uint256 indexed results);
    /**
    * Constructor inherits VRFConsumerBase
    *
    * Network: Rinkeby
    * Chainlink VRF Coordinator address: 0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B
    * LINK token address: 0x01BE23585060835E02B77ef475b0Cc51aA1e0709
    * Key Hash: 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311
    *
    * REMEMBER to SEND Contract some LINK Token
    */
    constructor()
    VRFConsumerBase(
        0xb3dCcb4Cf7a26f6cf6B120Cf5A73875B7BBc655B, // VRF Coordinator
        0x01BE23585060835E02B77ef475b0Cc51aA1e0709 // LINK Token
        ) public
        {
        keyHash = 0x2ed0feb3e7fd2022120aa84fab1945545a9f2ffc9076fd6156fa96eaff4c1311;
        fee = 0.1 * 10 ** 18; // 0.1 LINK (Varies by network)
        }
        /**
        * Requests randomness from a user-provided seed
        */
    function getRandomNumber(uint256 userProvidedSeed) public returns (bytes32 requestId) {
        require(LINK.balanceOf(address(this)) >= fee, "Not enough LINK - fill contract with faucet");
        return requestRandomness(keyHash, fee, userProvidedSeed);
        }
        /**
        * Callback function used by VRF Coordinator
        */
    function fulfillRandomness(bytes32 requestId, uint256 randomness) internal override {
        reqId=requestId;
        randomResult = randomness % 100;
        emit RandomNumberReceived(reqId, randomResult);
        }
    }