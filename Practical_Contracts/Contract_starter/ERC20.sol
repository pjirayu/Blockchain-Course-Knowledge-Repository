// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/IERC20.sol";

contract ERC20 is IERC20 {

  mapping (address => uint256) private _balances;
  mapping (address => mapping (address => uint256)) private _allowed;
  uint256 private _totalSupply;
  string private _name;
  string private _symbol;  
  
  function totalSupply() public view override returns (uint256) {
    return _totalSupply;
  }

  function balanceOf(address owner) public view override returns (uint256) {
    return _balances[owner];
  }

function allowance(address owner, address spender) public view override returns (uint256){
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
  
// function transfer_print(uint256 value) public view pure returns (uint){
    
// }

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
    require(to != address(0));

    _balances[from] = _balances[from] - value;
    _balances[to] = _balances[to] + value;
    _allowed[from][msg.sender] = _allowed[from][msg.sender] - value;
    emit Transfer(from, to, value);
    return true;
  }
  function _mint(address account, uint256 amount) internal {
    require(account != address(0));
    _totalSupply = _totalSupply + amount;
    _balances[account] = _balances[account] + amount;
    emit Transfer(address(0), account, amount);
  }
}

// initial supply
// constructor(string memory name, string memory symbol, uint256 totalSupply){
//       _totalSupply = totalSupply;
//       _name = name;
//       _symbol = symbol;
//       _balances[msg.sender] = totalSupply;
//   }