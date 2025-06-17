// contracts/MyToken.sol
// SPDX-License-Identifier: MIT

pragma solidity ^0.8.26;
import "hardhat/console.sol";

import "./Parent.sol";

contract Parent {
    function myFuParent() public pure returns (uint256) {
        return 42;
    }
}

contract Children is Parent {}

// ================

contract ParentA {
    function myFuParentA() public pure returns (uint256) {
        return 42;
    }
}

contract ParentB {
    function myFuParentB() public pure returns (uint256) {
        return 15;
    }
}

contract ChildrenC is ParentA, ParentB {}

//  ==========================================

contract ParentAA {
    function myFuParentA() public pure returns (uint256) {
        return 42;
    }
}

contract ChildrenBB is ParentAA {
    function myFuParentB() public pure returns (uint256) {
        return 15;
    }
}

contract ChildrenDD is ParentAA, ChildrenBB {
    function myFuParentBD() public pure returns (uint256) {
        uint256 num = ChildrenBB.myFuParentB() + super.myFuParentA(); // аналог вызова
        return num;
    }
}

//  ====================================================
contract ParentS {
    function myFuPablic() public pure returns (uint256) {
        return 42;
    }

    function myFuPrivate() private pure returns (uint256) {
        return 42;
    }

    function myFuInternal() internal pure returns (uint256) {
        return 42;
    }
}

contract ChildrenWW is ParentS {
    function demo() public pure {
        myFuPablic();
        // myFuPrivate();  ошибка, функция приватная
    }
}

// ===================================

contract ParentAAA {
    uint256 public value;

    constructor(uint256 _input) {
        value = _input;
    }

    function myFuParentA() public pure returns (uint256) {
        return 42;
    }

    function myFuConst() public pure virtual returns (uint256) {
        return 22;
    }

    function myFuConstVirtual() public pure virtual returns (uint256) {
        return 22;
    }
}

contract ChildrenCCC is ParentAAA(111) {
    uint256 public childValue;

    constructor(uint256 _input) {
        value = _input;
    }

    function demos() public pure returns (uint256) {
        return ParentAAA.myFuParentA();
    }

    function myFuConst() public pure override returns (uint256) {
        // virtual - разрешает переопределение ниже по иерархии
        // override - переопределяем
        return super.myFuConst() * 2;
    }

    function myFuConstVirtual()
        public
        pure
        virtual
        override(ParentAAA)
        returns (uint256)
    {
        return super.myFuConstVirtual() * 2;
    }
}

contract ChildrenCCCC is ChildrenCCC(999) {
    function myFuConstVirtual()
        public
        pure
        override(ChildrenCCC)
        returns (uint256)
    {
        return super.myFuConstVirtual() * 2;
    }
}

//  ====================================================

contract ChildrenCCCs is ParentAAAs, ParentAAAb {
    uint256 public childValue;

    constructor(uint256 _input, uint256 _input2)
        ParentAAAs(_input)
        ParentAAAb(_input2)
    {
        // передать динамически в конструктор данные
        childValue = _input;
    }
}
