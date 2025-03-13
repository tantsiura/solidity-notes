// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface Demo {
    function getName() external view returns (string memory);
}

contract Other {
    function callDemo(Demo _demo) public view returns (string memory) {
        return _demo.getName();
    }
}
