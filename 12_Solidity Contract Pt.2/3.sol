contract Compute {
 uint public data;
 uint public info;
 //uint public incrementresult;
 
 constructor() {
 info = 10;
 }
 //private function
 function increment(uint a) internal pure returns(uint) { return
a + 1; }

 //public function
 function setData(uint a) public { data = a; }
 function getData() virtual public view returns(uint) { return
data; }
 function compute(uint a, uint b) internal pure returns (uint)
{ return a + b; }

// function Incremented() public { incrementresult = increment(data); }
// function getIncrementedResult() public view returns(uint) { return incrementresult; }

}


//Derived Contract
contract DCompute is Compute {
 uint private result;
 uint private incrementresult;

 constructor() {

 }
 function getComputedResult() public {
 result = compute(3, 5);
 }
 function getResult() public view returns(uint) { return
result; }
 function getinfo() public view returns(uint) { return info; }
 
 
 function Incremented() public {
     incrementresult = increment(5); }
 function getIncrementedResult() public view returns(uint) { return incrementresult; }

 