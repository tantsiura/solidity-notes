// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";

contract SharedWallet is Ownable {
    // Structure to represent a user
    struct User {
        string name;
        uint limit;
        bool is_admin;
    }

    // Mapping of users
    mapping(address => User) public members;

    // Event emitted when a user's limit is changed
    event LimitChanged(address indexed user, uint oldLimit, uint newLimit);
    event UserAdded(address indexed user, string name);
    event UserRemoved(address indexed user);
    event AdminGranted(address indexed user);
    event AdminRevoked(address indexed user);

    // Function to add a user with a name and limit
    function addUser(address _member, string memory _name, uint _limit) public onlyOwner {
        // Initialize user details
        members[_member].name = _name;
        members[_member].limit = _limit;
        members[_member].is_admin = false;

        emit UserAdded(_member, _name);
    }

    // Function to change a user's limit
    function changeLimit(address _member, uint _newLimit) public onlyOwner {
        // Store the old limit before changing it
        uint oldLimit = members[_member].limit;
        members[_member].limit = _newLimit;

        emit LimitChanged(_member, oldLimit, _newLimit);
    }

    // Function to remove a user
    function removeUser(address _member) public onlyOwner {
        // Delete the user from the mapping
        delete members[_member];

        emit UserRemoved(_member);
    }

    // Function to grant admin rights to a user
    function makeAdmin(address _member) public onlyOwner {
        // Set the user as an admin
        members[_member].is_admin = true;

        emit AdminGranted(_member);
    }

    // Function to revoke admin rights from a user
    function revokeAdmin(address _member) public onlyOwner {
        // Remove admin rights from the user
        members[_member].is_admin = false;

        emit AdminRevoked(_member);
    }

    // Modifier to ensure the sender is either the owner or within their limit
    modifier ownerOrWithinLimits(uint _amount) {
        // Check if the sender is the owner, an admin, or within their limit
        require(isOwner() || members[_msgSender()].is_admin || members[_msgSender()].limit >= _amount, "You are not allowed to perform this operation!");
        _;
    }

    // Function to deduct from a user's limit
    function deduceFromLimit(address _member, uint _amount) internal {
        // Only deduct if the user is not an admin
        if (!members[_member].is_admin) {
            members[_member].limit -= _amount;
        }
    }

    // Override renounceOwnership to prevent it from being called
    function renounceOwnership() override public view onlyOwner {
        revert("Can't renounce!");
    }
}
