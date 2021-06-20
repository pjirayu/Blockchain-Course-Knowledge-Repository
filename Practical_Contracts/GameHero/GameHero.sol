// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";


contract RandomBattle2  {
    
    struct Hero {        
        string name;        
        uint dna;        
        uint32 level;        
        uint16 winCount;        
        uint16 lossCount;    
    }    
    Hero[] public heroes;    
    mapping (uint => address) public heroToOwner;    
    uint nonce = 0;    
    uint attackerProbability = 55;    
    IERC20 tokenAddress;
    
    event NewHero(uint heroId, string name, uint dna);    
    event attackWon(uint attackerId, uint targetId, uint winnerId);    

    modifier ownerOf(uint _heroId) {        
        require(msg.sender == heroToOwner[_heroId]);       
         _;    
    }
    constructor(address erc20Address){
         tokenAddress=IERC20(erc20Address);
    }

    //caller of this function is msg.sender
    function createHero(string calldata  _name, uint _dna) external {       
       heroes.push(Hero(_name, _dna, 0, 0, 0));        
       uint id=heroes.length-1; //index begins with zero
       heroToOwner[id] = msg.sender;   
       //msg.sender of this function need to call approve in the ERC20 contract to this contract address first.
       //However msg.sender to transferFrom is this contract, therefore needs prior approval by 
       //the caller of createHero. 
       //the msg.sender of tokenAddress.transferFrom is this contract
       tokenAddress.transferFrom(msg.sender,address(this),1);
       emit NewHero(id, _name, _dna);    
    }
    
    //caller must be the same as _heroId
    function attack(uint _heroId, uint _targetId)   external ownerOf(_heroId) {        
          Hero storage myHero = heroes[_heroId];        
          Hero storage enemyHero = heroes[_targetId];        
          uint winnerId;      
          
          uint randomResult = uint(keccak256(abi.encodePacked(block.timestamp, msg.sender, nonce))) % 100;  
          nonce++;        
          if (randomResult <= attackerProbability) {         
                myHero.winCount++;           
                myHero.level++;          
                enemyHero.lossCount++;          
                winnerId = _heroId;    
                //transfer is called by this contract, so transferring tokens from this contract
                //to caller of this function (msg.sender) do not require approval
	tokenAddress.transfer(msg.sender,1);
         } 
        else {           
                //transfer is called by this contract, so transferring tokens from this contract
                //to caller of this function (msg.sender) do not require approval
               tokenAddress.transfer(heroToOwner[_targetId],1);
               myHero.lossCount++;          
               enemyHero.winCount++;          
               winnerId = _targetId;        
        }        
        emit attackWon(_heroId, _targetId, winnerId);    
        
    }

    
}