// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Storing Owner

contract Contract {

    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
    }
    
    function pay() external payable {
    }
    
    function tip() public payable {
        (bool s, ) = owner.call{ value: msg.value }("");
        require(s);
    }

    function donate() public {
        uint256 balance = address(this).balance;
        (bool success, ) = charity.call{value: balance}("");
        require(success, "Donation failed");
        selfdestruct(payable(msg.sender));
    }
}

//Receive Ether
contract Contract {

    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
    }
    
    function pay() external payable {
    }
    
    function tip() public payable {
        (bool s, ) = owner.call{ value: msg.value }("");
        require(s);
    }

    function donate() public {
        uint256 balance = address(this).balance;
        (bool success, ) = charity.call{value: balance}("");
        require(success, "Donation failed");
        selfdestruct(payable(msg.sender));
    }
}

//Tip Owner
contract Contract {

    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
    }
    
    function pay() external payable {
    }
    
    function tip() public payable {
        (bool s, ) = owner.call{ value: msg.value }("");
        require(s);
    }

    function donate() public {
        uint256 balance = address(this).balance;
        (bool success, ) = charity.call{value: balance}("");
        require(success, "Donation failed");
        selfdestruct(payable(msg.sender));
    }
}

//Charity
contract Contract {

    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
    }
    
    function pay() external payable {
    }
    
    function tip() public payable {
        (bool s, ) = owner.call{ value: msg.value }("");
        require(s);
    }

    function donate() public {
        uint256 balance = address(this).balance;
        (bool success, ) = charity.call{value: balance}("");
        require(success, "Donation failed");
        selfdestruct(payable(msg.sender));
    }
}

//Self Destruct
contract Contract {

    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {
    }
    
    function pay() external payable {
    }
    
    function tip() public payable {
        (bool s, ) = owner.call{ value: msg.value }("");
        require(s);
    }

    function donate() public {
        uint256 balance = address(this).balance;
        (bool success, ) = charity.call{value: balance}("");
        require(success, "Donation failed");
        selfdestruct(payable(msg.sender));
    }
}
