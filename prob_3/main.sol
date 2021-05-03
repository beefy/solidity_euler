// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Main {
    // The prime factors of 13195 are 5, 7, 13 and 29.
    // What is the largest prime factor of the number 600851475143 ?

    function main() public returns(uint) {
        return get_largest(prime_factors(600851475143));
    }

    // function gcd(uint a, uint b) public pure returns(uint) {
    //     while(b != 0) {
    //         uint temp = b;
    //         b = a % b;
    //         a = temp;
    //     }

    //     return a;
    // }

    function get_largest(uint[] memory arr) public pure returns(uint) {
        // get largest element in an array
        uint largest = 0;
        for(uint i = 0; i < arr.length; i++) {
            if(arr[i] > largest) {
                largest = arr[i];
            }
        }

        return largest;
    }

    uint[] factors = new uint[](0);
    function prime_factors(uint n) public returns(uint[] memory) {
        // https://en.wikipedia.org/wiki/Integer_factorization
        // Using trial division
        // https://en.wikipedia.org/wiki/Trial_division
        uint cur_factor = 2;
        while(n > 1) {
            if(n % cur_factor == 0) {
                factors.push(cur_factor);
                n /= cur_factor;
            } else {
                cur_factor += 1;
            }
        }

        return factors;
    }
}
