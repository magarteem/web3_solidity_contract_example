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

    // Struct array ========================================
    struct BalanceArray {
        uint256 amount;
        uint256 timestamp;
    }

    BalanceArray[] public balanceArrays;

    function sampleStructArray() public payable {
        BalanceArray memory balanceArr = BalanceArray(
            msg.value,
            block.timestamp
        );

        balanceArrays.push(balanceArr);
    }

    function sampleWidthraw(address payable _to) public {
        uint256 titalBalanceArrays;

        for (uint256 i = 0; i < balanceArrays.length; i++) {
            titalBalanceArrays += balanceArrays[i].amount;
        }

        _to.transfer(titalBalanceArrays);
    }

    // Сложная структура ==================================================

    struct PaymentStruct {
        uint256 amount;
        uint256 timestamp;
    }

    struct BalanceStruct {
        uint256 totalBalance;
        mapping(uint256 => PaymentStruct) variable;
    }
}
