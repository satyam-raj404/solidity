// SPDX-Licence-Identifier: GPL-3.0
pragma solidity ^0.5.0;

contract array
{
   string[] public myarray;

   function test() public{
      myarray.push("hi");
   }
   function getarray() public view returns (string[]){
      return myarray;
   }
}

/*
contract test {
   function testArray() public pure{
      uint len = 7; 
      
      //dynamic array
      uint[] memory a = new uint[](7);
      
      //bytes is same as byte[]
      bytes memory b = new bytes(len);
      
      assert(a.length == 7);
      assert(b.length == len);
      
      //access array variable
      a[6] = 8;
      
      //test array variable
      assert(a[6] == 8);
      
      //static array
      uint[3] memory c = [uint(1) , 2, 3];
      assert(c.length == 3);
   }
   }
}
*/
