// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Person {
    string public name;
    string public surname;

    function setName(string memory _name) public {
        name = _name;
    }

    function setSurName(string memory _surname) public {
        surname = _surname;
    }

    function getName() external view returns(string memory) {
        return name;
    }

    function getSurName() external view returns(string memory) {
        return surname;
    }
}

contract Caller {
    function multiCallTx(address[] calldata targets, bytes[] calldata data) public returns(string[] memory) {
        require(targets.length == data.length, "invalid target");
        string[] memory results = new string[](targets.length);

        for(uint i; i < targets.length; i++) {
            (bool success, bytes memory result) = targets[i].call(data[i]);
            require(success, "call failed!");
            results[i] = abi.decode(result, (string));

        }
        return results;
    }
}
