// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ENSRegistrar {
    struct DomainInfo {
        address owner;
        uint256 creationTime;
        uint256 price;
    }

    mapping(string => DomainInfo) private domains;
    address public owner;
    uint256 public constant REGISTRATION_PRICE = 0.1 ether;

    event DomainRegistered(string domain, address owner, uint256 price);
    event Withdrawal(address to, uint256 amount);

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    modifier domainNotRegistered(string memory domain) {
        require(domains[domain].owner == address(0), "Domain is already registered");
        _;
    }

    function registerDomain(string memory domain) public payable domainNotRegistered(domain) {
        require(msg.value >= REGISTRATION_PRICE, "Insufficient payment for domain registration");

        domains[domain] = DomainInfo({
            owner: msg.sender,
            creationTime: block.timestamp,
            price: msg.value
        });

        emit DomainRegistered(domain, msg.sender, msg.value);
    }

    function getDomainOwner(string memory domain) public view returns (address) {
        return domains[domain].owner;
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Withdrawal failed");

        emit Withdrawal(owner, balance);
    }
}

