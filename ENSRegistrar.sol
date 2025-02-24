// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//ENS Domain Registrar Smart Contract

//Create a Solidity smart contract for an ENS (Ethereum Name Service) domain registrar with the following features:

//- A function to register a string (domain name) and associate it with a structure containing:
//- User's address
//- Registration timestamp
//- Price paid for registration
//The registration function should be payable and deduct funds for domain registration.
//A function to lookup an address by providing a string (ENS domain).
//A function to withdraw funds from the contract.
//(Optional) Implement necessary modifiers and additional functions to enhance contract logic and security.

contract ENSRegistrar {
    //The structure contains information about the domain owner, creation time and registration price.
    struct DomainInfo {
        address owner;
        uint256 creationTime;
        uint256 price;
    }

    //Domains mapping connects a string representation of a domain with information about it.
    mapping(string => DomainInfo) private domains;
    address public owner;
    uint256 public constant REGISTRATION_PRICE = 0.1 ether;

    //Events were used to log domain registrations and withdrawals.
    event DomainRegistered(string domain, address owner, uint256 price);
    event Withdrawal(address to, uint256 amount);


    constructor() {
        owner = msg.sender;
    }
    
    //Added onlyOwner and domainNotRegistered modifiers to ensure security and correct operation logic.
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    modifier domainNotRegistered(string memory domain) {
        require(domains[domain].owner == address(0), "Domain is already registered");
        _;
    }

    //The registerDomain function allows users to register domains.
    //It verifies that the domain has not yet been registered and that enough funds have been sent.
    function registerDomain(string memory domain) public payable domainNotRegistered(domain) {
        require(msg.value >= REGISTRATION_PRICE, "Insufficient payment for domain registration");

        domains[domain] = DomainInfo({
            owner: msg.sender,
            creationTime: block.timestamp,
            price: msg.value
        });

        emit DomainRegistered(domain, msg.sender, msg.value);
    }

    //The getDomainOwner function returns the owner address for a given domain.
    function getDomainOwner(string memory domain) public view returns (address) {
        return domains[domain].owner;
    }

    //The withdraw function allows the contract owner to withdraw accumulated funds.
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Withdrawal failed");

        emit Withdrawal(owner, balance);
    }
}
