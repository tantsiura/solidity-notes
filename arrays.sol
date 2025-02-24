// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

//Fixed Sum
contract Contract {
    
    function sum(uint[5] calldata numbers) external pure returns (uint) {
    uint result = 0;
    for (uint i = 0; i < numbers.length; i++) {
        result += numbers[i];
    }
    return result;
}
}

//Dynamic Sum
contract Contract {
    function sum(uint[] calldata numbers) external pure returns (uint) {
        uint result = 0;
        for (uint i = 0; i < numbers.length; i++) {
            result += numbers[i];
        }
        return result;
    }
}

//Filter to Storage
contract Contract {

    uint[] public evenNumbers;

    function filterEven(uint[] calldata numbers) external {
        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenNumbers.push(numbers[i]);
            }
        }
    }
    
}

//Filter to Memory
contract Contract {
    uint public constant x = 4;

    function filterEven(uint[] calldata numbers) external pure returns (uint[] memory) {
        uint[] memory evenNumbers = new uint[](x);
        uint evenCount = 0;

        for (uint i = 0; i < numbers.length; i++) {
            if (numbers[i] % 2 == 0) {
                evenNumbers[evenCount] = numbers[i];
                evenCount++;
            }
        }

        uint[] memory result = new uint[](evenCount);
        for (uint i = 0; i < evenCount; i++) {
            result[i] = evenNumbers[i];
        }
        return result;
    }
}

//Stack Club 1
contract StackClub {

    address[] public members;

    function addMember(address newMember) external {
        members.push(newMember);
    }

    function isMember(address addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == addr) {
                return true;
            }
        }
        return false;
    }
    
}

//Stack Club 2
contract StackClub {
    address[] public members;
    address public deployer;

    error NotMember(address);

    constructor() {
        deployer = msg.sender;
        members.push(deployer);
    }

    function addMember(address newMember) external {
        if (!isMember(msg.sender)) {
            revert NotMember(msg.sender);
        }
        members.push(newMember);
    }

    function isMember(address addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == addr) {
                return true;
            }
        }
        return false;
    }

    function removeLastMember() public {
        if (!isMember(msg.sender)) {
            revert NotMember(msg.sender);
        }
        members.pop();
    }
}
