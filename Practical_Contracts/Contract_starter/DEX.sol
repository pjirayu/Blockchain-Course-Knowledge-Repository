//To keep things simple, we just exchange 1 token for 1 ether.

//The basic structure of the contract: 

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;
import "./IERC.sol";
// import "ERC.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";


contract DEX {

    ERC20 public token;

    event Bought(uint256 amount);
    event Sold(uint256 amount);
    address erc20add = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2; // default: 0x9a2E12340354d2532b4247da3704D2A5d73Bd189;
    constructor()  {
        token = ERC20(erc20add);
    }

    function buy() payable public {
        uint256 amountTobuy = msg.value;
        uint256 dexBalance = token.balanceOf(address(this));
        require(amountTobuy > 0, "You need to send some ether");
        require(amountTobuy <= dexBalance, "Not enough tokens in the reserve");
        token.transfer(msg.sender, amountTobuy);
        emit Bought(amountTobuy);
    }
  function sell(uint256 amount) public {
    require(amount > 0, "You need to sell at least some tokens");
    uint256 allowance = token.allowance(msg.sender, address(this)); 
    require(allowance >= amount, "Check the token allowance");
    token.transferFrom(msg.sender, address(this), amount);
    payable(msg.sender).transfer(amount);
    emit Sold(amount);
  }

}

