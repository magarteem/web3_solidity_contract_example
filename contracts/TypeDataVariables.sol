// contracts/MyToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
import "hardhat/console.sol";

contract TypeDataVariables {
    mapping(address => bool) buyers;
    uint256 public price = 2 ether;
    address public owner;
    address public shopAddress;
    bool fullPaid;

    event ItemFullPaid(uint256 _price, address shopAddress);

    constructor() {
        owner = msg.sender;
        shopAddress = address(this);
    }

    // Enum
    enum Status {
        Paid,
        Delivered,
        Received
    }
    Status public currentStatus;

    function pay() public {
        currentStatus = Status.Paid;
    }

    function delivered() public {
        currentStatus = Status.Delivered;
    }

    function checked() public view {
        if (currentStatus == Status.Paid) {
            // code
        }
    }

    // Array
    uint256[10] public items = [1, 2, 3];
    string[5] public itemsStr = ["wwwwwwwww", "tttttttt", "rrrr"];
    uint256[3][4] public arrayInner; //4 вложеных массива по 3 элементы
    uint256[] public arrayDynamicLangth;
    // Массивы последовательности байт
    bytes32 public myVar = "str";
    bytes public myVarDynamickLength = "st r"; //динамичекская длина массива
    bytes public myVarDynamickLengthUnicode = unicode"Привет мир !"; //динамичекская длина массива кириллицы

    function demo() public {
        items[0] = 100;
        items[3] = 200;
        items[6] = 500;
        itemsStr[0] = "500str";
        itemsStr[2] = "800str";
        arrayInner = [[3, 4, 5], [6, 7, 8], [9, 10, 11], [12, 13, 14]];
        arrayDynamicLangth.push(4);
        arrayDynamicLangth.push(5);
        arrayDynamicLangth.push(44);
        console.log(arrayDynamicLangth.length);
        arrayDynamicLangth.pop();
        console.log(arrayDynamicLangth.length);
    }

    function calcLengthArray() public view returns (uint256) {
        return myVarDynamickLength.length; //4
        // return myVar.length; //32
    }

    function calcLengthArray2() public view returns (uint256) {
        return myVarDynamickLengthUnicode.length; //21
    }

    function calcArrayElemBytes() public view returns (bytes1) {
        return myVarDynamickLength[0]; //
    }

    function forMappingArrays() public view {
        for (uint256 i = 0; i < itemsStr.length; i++) {
            console.log(itemsStr[i]);
        }
    }

    //временный массив
    function sampleMemory() public pure returns (uint256[] memory) {
        uint256[] memory tempArray = new uint256[](10); // Временный массив
        tempArray[3] = 1;
        return tempArray;
    }

    // ===========================================================================
    function getBuyer(address _addr) public view returns (bool) {
        require(owner == msg.sender, "You are not an owner");

        return buyers[_addr];
    }

    function addBuyer(address _addr) public {
        require(owner == msg.sender, "You are not an owner");
        buyers[_addr] = true;
    }

    function getBalance() public view returns (uint256) {
        return shopAddress.balance;
    }

    function widthdrawAll() public {
        require(
            owner == msg.sender && fullPaid && shopAddress.balance > 0,
            "Rejected"
        );

        address payable receiver = payable(msg.sender);
        receiver.transfer(shopAddress.balance);
    }

    receive() external payable {
        require(buyers[msg.sender] && msg.value <= price, "Rejected");
        if (shopAddress.balance == price) {
            fullPaid = true;

            emit ItemFullPaid(price, shopAddress);
        }
    }
}
