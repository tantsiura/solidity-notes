// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    string public name = "John";
    uint public age = 30;
    mapping(address => uint) public payments;

    function setData(string calldata _newName, uint _newAge) public {
        name = _newName;
        age = _newAge;
    }

    function getName() public view returns(string memory) {
        return name;
    }

    function pay(address _payer) external payable {
        payments[_payer] = msg.value;
    }
}
