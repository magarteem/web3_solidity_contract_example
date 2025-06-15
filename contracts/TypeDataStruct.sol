// contracts/MyToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
import "hardhat/console.sol";

contract TypeDataStruct {
    // Struct (Сложные структуры данных)
    struct Payment {
        uint256 amount;
        uint256 timestamp;
        address from;
        string message;
    }

    struct Balance {
        uint256 totalPayment;
        mapping(uint256 => Payment) payments;
    }

    mapping(address => Balance) public balances;

    function pay1(string memory message) public payable {
        uint256 paymentNumber = balances[msg.sender].totalPayment;
        balances[msg.sender].totalPayment++;

        Payment memory newPayment = Payment(
            msg.value,
            block.timestamp,
            msg.sender,
            message
        );
        balances[msg.sender].payments[paymentNumber] = newPayment;
    }

    function getPaymentBalances(address _addr, uint256 _index)
        public
        view
        returns (Payment memory)
    {
        return balances[_addr].payments[_index];
    }
}
