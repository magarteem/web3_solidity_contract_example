// contracts/MyToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GetTransferBalance {
    mapping(address => uint256) public payments;

    function receiveFunds() external payable {
        console.log(msg.value);
        payments[msg.sender] = msg.value;
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function transferTo(address payable targetAdder, uint256 amount) public {
        // address payable _to = payable(targetAdder);
        targetAdder.transfer(amount);
    }

    function withdrawFunds(address payable _to) external {
        //   address target = payable (_to);
        _to.transfer(address(this).balance);
    }
}
