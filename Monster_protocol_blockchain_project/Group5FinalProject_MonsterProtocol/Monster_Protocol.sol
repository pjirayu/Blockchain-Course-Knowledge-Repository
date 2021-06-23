// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0 <=0.9.0;

// ERC-20
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol"; 
// ERC-721
import "/.deps/github/0xcert/ethereum-erc721/src/contracts/tokens/nf-token-metadata.sol";
import "/.deps/github/0xcert/ethereum-erc721/src/contracts/ownership/ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract MonsterProtocol is IERC20 {

  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint256)) private _allowed;
  uint256 private _totalSupply;
  string private _name;
  string private _symbol;
  
//   In case of fixing the static contract on only once address
//   address account;
//   uint value;
  
//   constructor (address _player,uint _participated_value) {
//         account = _player;
//         value = _participated_value;
//     }
    
// ==========================================================================================================
// Foundation of transaction system
  
  function totalSupply() public view override returns (uint256) {
    return _totalSupply;
  }
  function balanceOf(address owner) public view override  returns (uint256) {
    return _balances[owner];
  }
  function allowance(address owner, address spender) public view override  returns (uint256){
    return _allowed[owner][spender];
  }
  function transfer(address to, uint256 value) public override returns (bool) {
    require(value <= _balances[msg.sender]);
    require(to != address(0));
    _balances[msg.sender] = _balances[msg.sender] - value;
    _balances[to] = _balances[to] + value;
    emit Transfer(msg.sender, to, value);
    return true;
  }
  function approve(address spender, uint256 value) override public returns (bool) {
    require(spender != address(0));

    _allowed[msg.sender][spender] = value;
    emit Approval(msg.sender, spender, value);
    return true;
  }
  function transferFrom(address from, address to, uint256 value ) public override returns (bool)
  {
    require(value <= _balances[from]);
    require(value <= _allowed[from][msg.sender]);
    require(value ==2 || value ==10 ||value==50||value==500);
    require(to != address(0));

    _balances[from] = _balances[from] - value;
    _balances[to] = _balances[to] + value;
    _allowed[from][msg.sender] = _allowed[from][msg.sender] - value;
    emit Transfer(from, to, value);
    return true;
  }

// ==========================================================================================================
//Monster minting the reward in each level + sned to incinerator
  address Monster_Dungeon = 0x519A2A7A231515FeE1de8055F4230F8182732E59; // Go to incinerate wallet for burning
//   address MOP_cash = 0x6cC95d2Ef35c2ad91FFf565426956Edd1a7e9b52; // Contract address of main MOR currency
  uint256 none_token = 0;


//   constructor (address Monster_Dungeon)  {
//           _forburn = IERC20(Monster_Dungeon);
//     }
//---------------------------------------V3 Minting & Burning same contract----------------------------------------
  // 1st-drop 10K token
  function Airdrop(address From_wallet) public {
     require(none_token <= _balances[From_wallet]);
     require(From_wallet != address(0));
     _totalSupply = _totalSupply + 10000;
     _balances[From_wallet] = _balances[From_wallet] +10000;
     emit Transfer(address(0), From_wallet, 10000);
   }
  
  // daily free 10 token
  function Daily_free_minter(address From_wallet) public {
     require(From_wallet != address(0));
     _totalSupply = _totalSupply + 10;
     _balances[From_wallet] = _balances[From_wallet] +10;
     emit Transfer(address(0), From_wallet, 10);
   }

  function _baby_minter_burner(address From_wallet, uint256 amount) public {
    //common_monster
    if (amount == 2){
    // address Monster_Dungeon = 0x519A2A7A231515FeE1de8055F4230F8182732E59; // Go to incinerator
    
    //buying ticket == send to incinerator   
    // require(_balances[From_wallet] >= 2, "Monster Protocol is empty, see you next times");
    require(amount <= _balances[From_wallet]);

    //minting the reward via randomish
    require(From_wallet != address(0));
    
    _totalSupply = _totalSupply + block.timestamp%6 * 98/100;
    _balances[Monster_Dungeon] = _balances[Monster_Dungeon] + amount;
    _balances[From_wallet] = _balances[From_wallet] - amount + block.timestamp%6 * 98/100;
    emit Transfer(address(0), From_wallet, block.timestamp%6 * 98/100); // 2% fee reward back
    emit Transfer(address(0), Monster_Dungeon, amount);
    // return true;
    }
 }
 
   function _common_minter_burner(address From_wallet, uint256 amount) public {
    //common_monster
    if (amount == 10){
    // address Monster_Dungeon = 0x519A2A7A231515FeE1de8055F4230F8182732E59; // Go to incinerator
    
    //buying ticket == send to incinerator   
    // require(_balances[From_wallet] >= 2, "Monster Protocol is empty, see you next times");
    require(amount <= _balances[From_wallet]);

    //minting the reward via randomish
    require(From_wallet != address(0));
    
    _totalSupply = _totalSupply + block.timestamp%11 * 98/100;
    _balances[Monster_Dungeon] = _balances[Monster_Dungeon] + amount;
    _balances[From_wallet] = _balances[From_wallet] - amount + block.timestamp%11 * 98/100;
    emit Transfer(address(0), From_wallet, block.timestamp%11 * 98/100); // 2% fee reward back
    emit Transfer(address(0), Monster_Dungeon, amount);
    // return true;
    }
 }
 
    function _miniboss_minter_burner(address From_wallet, uint256 amount) public {
    //common_monster
    if (amount == 50){
    // address Monster_Dungeon = 0x519A2A7A231515FeE1de8055F4230F8182732E59; // Go to incinerator
    
    //buying ticket == send to incinerator   
    // require(_balances[From_wallet] >= 2, "Monster Protocol is empty, see you next times");
    require(amount <= _balances[From_wallet]);

    //minting the reward via randomish
    require(From_wallet != address(0));
    
    _totalSupply = _totalSupply + block.timestamp%101 * 98/100;
    _balances[Monster_Dungeon] = _balances[Monster_Dungeon] + amount;
    _balances[From_wallet] = _balances[From_wallet] - amount + block.timestamp%101 * 98/100;
    emit Transfer(address(0), From_wallet, block.timestamp%101 * 98/100); // 2% fee reward back
    emit Transfer(address(0), Monster_Dungeon, amount);
    // return true;
    }
 }
 
    function _boss_minter_burner(address From_wallet, uint256 amount) public {
    //common_monster
    if (amount == 500){
    // address Monster_Dungeon = 0x519A2A7A231515FeE1de8055F4230F8182732E59; // Go to incinerator
    
    //buying ticket == send to incinerator   
    // require(_balances[From_wallet] >= 2, "Monster Protocol is empty, see you next times");
    require(amount <= _balances[From_wallet]);

    //minting the reward via randomish
    require(From_wallet != address(0));
    
    _totalSupply = _totalSupply + block.timestamp%1001 * 98/100;
    _balances[Monster_Dungeon] = _balances[Monster_Dungeon] + amount;
    _balances[From_wallet] = _balances[From_wallet] - amount + block.timestamp%1001 * 98/100;
    emit Transfer(address(0), From_wallet, block.timestamp%1001 * 98/100); // 2% fee reward back
    emit Transfer(address(0), Monster_Dungeon, amount);
    // return true;
    }
 }

contract Supersoul is NFTokenMetadata, Ownable {
constructor() {
nftName = "Supersoul Monster Protocol";
nftSymbol = "SSMOP";
}
    function _ss_minter(address _to, uint256 _tokenId, string calldata _uri) external onlyOwner {
        super._mint(_to, _tokenId);
        super._setTokenUri(_tokenId, _uri);
    }
}