// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.28;

contract itContract {
    string public name = "itProger";
    string public symbol = "ITG";
    uint public decimal = 18;
    uint256 public totalSupply;

    mapping(address => uint256) public balance0f;

    //события операции перевода
    event Transfer(address indexed from, address indexed to, uint256 value);

    // конструктор создаёт начальное кол-во токенов
    constructor(uint256 _initialSupply) {
        totalSupply = _initialSupply * 10 ** uint256(decimal);
        balance0f[msg.sender] = totalSupply;
    }

    // функция для перевода токена
    function transfer(
        address _to,
        uint256 _value
    ) public returns (bool success) {
        require(balance0f[msg.sender] >= _value);
        balance0f[msg.sender] -= _value;
        balance0f[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }
}
