// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

//Setup

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

}

//Constructor
contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    constructor(address _arbiter, address _beneficiary) {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

}

//Funding
contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }
}

//Approval

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only the arbiter can approve the transaction");
        uint256 balance = address(this).balance;
        payable(beneficiary).transfer(balance);
    }
}

//Security
contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    error NotItemCreator(address);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        if(msg.sender != arbiter) {
            revert NotItemCreator(msg.sender);
        }
        require(msg.sender == arbiter, "Only the arbiter can approve the transaction");
        uint256 balance = address(this).balance;
        payable(beneficiary).transfer(balance);
    }
}

//Events
contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    error NotItemCreator(address);

    event Approved(uint);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        if(msg.sender != arbiter) {
            revert NotItemCreator(msg.sender);
        }
        require(msg.sender == arbiter, "Only the arbiter can approve the transaction");
        uint256 balance = address(this).balance;
        payable(beneficiary).transfer(balance);
        emit Approved(balance);
    }
}
