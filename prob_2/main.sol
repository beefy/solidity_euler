// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Main {
    // Each new term in the Fibonacci sequence is generated by 
    // adding the previous two terms. 
    // By starting with 1 and 2, the first 10 terms will be:
    //      1, 2, 3, 5, 8, 13, 21, 34, 55, 89, ...
    // By considering the terms in the Fibonacci sequence 
    // whose values do not exceed four million, 
    // find the sum of the even-valued terms.

    uint[] memo = [1, 1];

    function main() public returns(uint) {
        uint sum;
        uint fib_counter = 1;
        uint fib_value = fib(fib_counter);
        while(fib_value < 4000000) {
            fib_counter += 1;
            fib_value = fib(fib_counter);
            if(fib_value % 2 == 0) {
                sum += fib_value;
            }
        }

        return sum;
    }

    function fib(uint n) public returns(uint) {
        // Non-memoized
        // if(n <= 2) return n;
        // return fib(n-1) + fib(n-2);

        // memoized
        if(n < memo.length) {
            return memo[n];
        }

        memo.push(fib(n-1) + fib(n-2));
        return memo[n];
    }
}
