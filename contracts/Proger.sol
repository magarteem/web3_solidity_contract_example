// contracts/MyToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.28;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Proger is ERC20 {
    constructor(uint256 initialSupply) ERC20("Proger", "ITG") {
        _mint(msg.sender, initialSupply * 1000 * 10 ** decimals());
    }
}
