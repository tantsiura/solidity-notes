// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Demo {
    address public owner;
    event Deployed(address _thisAddr, uint _balance);

    //constructo

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}

contract create2 {
    event Log(address caller, string calcName, uint result);

    mapping(address => uint) public balances; 

    function pay() external payable {
        balances[msg.sender] += msg.value; 
    }
}
