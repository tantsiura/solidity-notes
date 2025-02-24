// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Add Member

contract Contract {
    mapping(address => bool) public members;
    address[] public memberList;

    function addMember(address _member) external returns (uint256) {

        require(!members[_member], "Member already exists.");
        
        members[_member] = true; 
        memberList.push(_member); 
        return getNumberOfMembers(); 
    }

    function getNumberOfMembers() public view returns (uint256) {
        return memberList.length; 
    }

    function isMember(address _member) external view returns (bool) {
        return members[_member];
    }
}

//Is Member

contract Contract {
    mapping(address => bool) public members;
    address[] public memberList;

    function addMember(address _member) external returns (uint256) {

        require(!members[_member], "Member already exists.");
        
        members[_member] = true; 
        memberList.push(_member); 
        return getNumberOfMembers(); 
    }

    function getNumberOfMembers() public view returns (uint256) {
        return memberList.length; 
    }

    function isMember(address _member) external view returns (bool) {
        return members[_member];
    }

}

//Remove Member
contract Contract {
    mapping(address => bool) public members;
    address[] public memberList;

    function addMember(address _member) external returns (uint256) {

        require(!members[_member], "Member already exists.");
        
        members[_member] = true; 
        memberList.push(_member); 
        return getNumberOfMembers(); 
    }

    function getNumberOfMembers() public view returns (uint256) {
        return memberList.length; 
    }

    function isMember(address _member) external view returns (bool) {
        return members[_member];
    }

    function removeMember(address addr) external {
        members[addr] = false;
    }

}

//Map Structs

contract Contract {
	struct User {
		uint balance;
		bool isActive;
	}

	mapping(address => User) public users;

	function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

}

//Map Structs 2
contract Contract {
    struct User {
        uint balance;
        bool isActive;
    }

    mapping(address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

    function transfer(address recipient, uint amount) external {
        require(users[msg.sender].isActive, "Sender is not an active user");
        require(users[recipient].isActive, "Recipient is not an active user");

        require(users[msg.sender].balance >= amount, "Insufficient balance");

        users[msg.sender].balance -= amount;
        users[recipient].balance += amount;
    }
}

//Nested Maps
contract Contract {
    enum ConnectionTypes { 
        Unacquainted,
        Friend,
        Family
    }
    
    mapping(address => mapping(address => ConnectionTypes)) public connections;

    function connectWith(address other, ConnectionTypes connectionType) external {
        require(other != msg.sender, "Cannot connect with yourself");
        connections[msg.sender][other] = connectionType;
    }
}
