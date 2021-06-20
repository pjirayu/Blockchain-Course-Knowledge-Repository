//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

contract HelloWorldBitkub {
    string message = "HelloWorld BitkubChain";
    
    function setMessage(string memory _message) public {
        message = _message;
    }
    
    function getMessage() public view returns(string memory){
        return message;
    }
}
