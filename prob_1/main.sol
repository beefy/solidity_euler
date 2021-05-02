// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Main {
    // If we list all the natural numbers below 10 that are multiples of 3 or 5,
    // we get 3, 5, 6 and 9. The sum of these multiples is 23.
    // Find the sum of all the multiples of 3 or 5 below 1000.

    uint ret = 0;

    function main() public returns (uint) {
        for(uint i=0; i < 1000; i++) {
            if(i % 3 == 0 || i % 5 == 0) {
                ret += i;
            }
        }
        return ret;
    }
}
