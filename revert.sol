// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;


//Constructor Revert
contract Contract {
    address payable public owner;
    uint256 public depositAmount;

    error NotItemCreator(address);

    constructor() payable {
        require(msg.value >= 1 ether, "Deposit must be at least 1 ether");
        owner = payable(msg.sender);
        depositAmount = msg.value;
    }

    function withdraw() public {
        if(msg.sender != owner) {
            revert NotItemCreator(msg.sender);
        }
        uint256 balance = address(this).balance;
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Donation failed");
        selfdestruct(payable(msg.sender));
    }
}

//Only Owner
contract Contract {
    address payable public owner;
    uint256 public depositAmount;

    error NotItemCreator(address);

    constructor() payable {
        require(msg.value >= 1 ether, "Deposit must be at least 1 ether");
        owner = payable(msg.sender);
        depositAmount = msg.value;
    }

    function withdraw() public {
        if(msg.sender != owner) {
            revert NotItemCreator(msg.sender);
        }
        uint256 balance = address(this).balance;
        (bool success, ) = owner.call{value: balance}("");
        require(success, "Donation failed");
        selfdestruct(payable(msg.sender));
    }
}

//Owner Modifier
contract Contract {
	uint configA;
	uint configB;
	uint configC;
	address owner;

	constructor() {
		owner = msg.sender;
	}

	function setA(uint _configA) public onlyOwner {
		configA = _configA;
	}

	function setB(uint _configB) public onlyOwner {
		configB = _configB;
	}

	function setC(uint _configC) public onlyOwner {
		configC = _configC;
	}

	modifier onlyOwner {
        require(msg.sender == owner, "Only the owner can call this function.");
        _;
    }
}
