// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// import "https://github.com/HQ20/contracts/blob/master/contracts/classifieds/Classifieds.sol";

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

contract Marketplace {
    event TradeStatusChange(uint256 ad, bytes32 status);

    // uint256 counter;
    IERC20 currency;
    IERC721 item;
    uint256 counter;

    struct Trade {
        address owner;
        uint256 item;
        uint256 price;
        uint256 status; // 0=Available, 1=Sold
    }
    
    mapping(uint256 => Trade) public trades;
    
    constructor (address _erc20, address _erc721) {             //(address _erc20, address _erc721)
        currency = IERC20(_erc20);
        item = IERC721(_erc721);
        counter = 0;
    }
    
    function sell(uint256 _item, uint256 _price) public {
        //transfer the item from seller to the contract as escrow
        item.transferFrom(msg.sender, address(this), _item);
        //keep track of trade
        trades[counter] = Trade({
        owner: msg.sender,
        item: _item,
        price: _price,
        status: 0
        });
        counter += 1; //trade id
        emit TradeStatusChange(counter - 1, "Open");
    }
    
    function buy(uint256 _trade) public {
        //retrieve the item for sale
        Trade memory trade = trades[_trade];
        require(trade.status == 0, "Trade is not available.");
        //transfer erc20 token from buyer=msg.sender to owner
        currency.transferFrom(msg.sender, trade.owner, trade.price);
        //transfer nft item to buyer=msg.sender
        item.transferFrom(address(this), msg.sender, trade.item);
        //mark item as sold
        trades[_trade].status = 1;
        emit TradeStatusChange(_trade, "Executed");
    }
}