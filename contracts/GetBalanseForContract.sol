// contracts/MyToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract GetBalanseForContract {
    string message = "hello";
    uint256 public balance;

    function getBalanse1() public view returns (uint256) {
        uint256 balanse1 = address(this).balance;
        return balanse1;
    }

    function getBalanse2() public view returns (uint256 balanse2) {
        balanse2 = address(this).balance;
    }

    // тип функции view разрешает  чтение вшешней переменной, pure не разрешает
    function getBalanse3() public view returns (string memory) {
        return message;
    }

    function rate(uint256 amount) public pure returns (uint256) {
        return amount * 3;
    }

    function setMessage(string memory newMessages) external {
        message = newMessages;
        // external не возвращает данные -  return message;
    }

    // type payable
    function pay() external payable {
        // зачислит пришедшие деньги на контракт. но этого можно и не писать. пустая  функция так же отработает
        balance += msg.value;
    }

    function payEmptyFu() external payable {
        // также отработает
    }

    //  receive - если есть то контракт готов принимать деньги, если они прилетели и  не указано какую ф-ю вызвать, может быть пустая фун-я
    receive() external payable {}

    // fallback - вызывается если пришла транзакция с вызовом неизвестной функции
    fallback() external payable {}
}
