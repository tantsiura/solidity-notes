// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Arguments
contract Contract {
    uint public x;

    constructor(uint y) {
        x = y;
    }

    function increment() external {
    x +=1;
    }

    function add(uint y) external view returns(uint) {
		return x+y;
	}
}

//Increment
contract Contract {
    uint public x;

    constructor(uint y) {
        x = y;
    }

    function increment() external {
    x +=1;
    }

    function add(uint y) external view returns(uint) {
		return x+y;
	}
}

//View Addition
contract Contract {
    uint public x;

    constructor(uint y) {
        x = y;
    }

    function increment() external {
    x +=1;
    }

    function add(uint y) external view returns(uint) {
		return x+y;
	}
}

//Console Log
contract Contract {
    function winningNumber(string calldata secretMessage) external returns(uint) {
        uint winningNumber = 794;

        console.log("The winning number is:", winningNumber);

        return winningNumber;
    }
}

//Pure Double
contract Contract {
    function double(uint x) external pure returns(uint) {
        return x*2;
    }

    function double(uint x, uint y) public pure returns(uint, uint) {
        return (x*2, y*2);
    }
}

//Double Overload
contract Contract {
    function double(uint x) external pure returns(uint) {
        return x*2;
    }

    function double(uint x, uint y) public pure returns(uint, uint) {
        return (x*2, y*2);
    }
}
