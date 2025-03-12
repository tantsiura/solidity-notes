// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    // Mapping of user addresses to their withdrawal limits
    mapping(address => uint) public members;

    // Function to add a user with a specified limit
    function addLimit(address _member, uint _limit) public onlyOwner {
        members[_member] = _limit;
    }

    // Internal function to check if the sender is the owner
    function isOwner() internal view returns(bool) {
        return owner() == _msgSender();
    }

    // Modifier to ensure the sender is either the owner or within their limit
    modifier ownerOrWithinLimits(uint _amount) {
        require(isOwner() || members[_msgSender()] >= _amount, "You are not allowed to perform this operation!");
        _;
    }

    // Function to deduct from a user's limit
    function deduceFromLimit(address _member, uint _amount) internal {
        members[_member] -= _amount;
    }

    // Override renounceOwnership to prevent it from being called
    function renounceOwnership() override public view onlyOwner {
        revert("Can't renounce!");
    }
}
