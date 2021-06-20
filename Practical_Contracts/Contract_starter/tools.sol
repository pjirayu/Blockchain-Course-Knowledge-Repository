// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Compute {
    uint private data;
    uint public info;
    constructor() {
    info = 10;
    }
    
    //public function
    function setData(uint a) public { data = a; }
    function getData() virtual public view returns(uint) { return data; }
    function compute(uint a, uint b) internal pure returns (uint) { return a + b; }
    }
//Derived Contract
contract DCompute is Compute {
    uint private result;
    constructor() {
    }
    
    function getComputedResult() public {
    result = compute(3, 5);
    }
    
    function getResult() public view returns(uint) { return result; }
    function getinfo() public view returns(uint) { return info; }
}


contract Calculator {
    modifier divideByZero(uint y) {
        require(y > 0);
        _;
    }
    function plus(uint8 x, uint y) public view returns (uint) {
        return x + y;
    }
    function minus(int x, int y) public view returns (int) {
        return  x - y;
    }
    function multiply(uint x, uint y) public view returns (uint) {
        return x * y;
    }
    function divide(uint x, uint y) public divideByZero(y) view returns (uint) {
        return x/y;
    }
}