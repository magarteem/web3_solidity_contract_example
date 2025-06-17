// contracts/MyToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
import "hardhat/console.sol";

contract ParentAAAs {
    uint256 public value;

    constructor(uint256 _input) {
        value = _input;
        console.log(value);
    }
}

contract ParentAAAb {
    uint256 public values;

    constructor(uint256 _input) {
        values = _input;
        console.log(values);
    }
}
