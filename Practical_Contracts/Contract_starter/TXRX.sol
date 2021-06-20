// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
// import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";
// -------------------------------------------------------
//balance_check of msg.sender
// -------------------------------------------------------
contract senderBalance {
    function Balance() public view returns (uint256){
        return msg.sender.balance;
    }
}
// -------------------------------------------------------
//contract balance (checking balance of referred address)
// -------------------------------------------------------
contract contractBalance {
    
    // opt.1 fix address
    // function Balance() public view returns (uint256){
    //     return address(this).balance;
    //     // return address(0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C).balance;
    // }
    
    // opt.2 filling out address from UI from "address payable receiver"
    function anyBalance(address payable receiver) public view returns (uint256){
        return receiver.balance;
        // return address(0x1aE0EA34a72D944a8C7603FfB3eC30a6669E454C).balance;
    }
    
    // receiving from tx
    function receive() external payable {
        
    }
    //transfer ETH
    function give(uint256 tx, address payable rx) public {
        rx.transfer(tx);
    }
}
