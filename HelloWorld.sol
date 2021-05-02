// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Main {
  string ret = "Hello World!";
  
  // Add this function:
  function main() public view returns(string memory) {
    return ret;
  }
}
