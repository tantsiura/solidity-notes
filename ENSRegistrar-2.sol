// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

//ENS Domain Registrar Smart Contract

//Create a Solidity smart contract for an ENS (Ethereum Name Service) domain registrar with the following features:

//- The contract must have an owner, and only this owner can withdraw money from the contract.
//- Add a variable for the price of one year of registration and create a setter for this price that can only be called by the owner.
//- Modify the function that maps a string to a structure.
//- The function should now take an argument for how many years the user is registering the domain. Minimum value is 1, maximum is 10.
//- Add this information to the structure as well. The fee for calling the function should depend on the registration period.
//- The function should check if the domain is available. A domain is considered available if it has no records or if the registration period has expired. For simplicity, assume that a year always has 365 days.
//- Add a function to renew the domain. It should check if the domain currently belongs to the transaction sender. It should also take an argument for how many years the user is renewing the domain.
//- The renewal function should be paid, but the renewal price should differ from the purchase price. Renewal price = purchase price * coefficient.
//- Add this coefficient and a setter for it to the contract. The setter, like the price setter, can only be called by the owner.

contract ENSRegistrar {
    // Structure containing information about the domain
    struct DomainInfo {
        address owner;
        uint256 registrationTime;
        uint256 expirationTime;
        uint256 price;
        uint256 registrationYears;
    }

    // Mapping of domain names to their information
    mapping(string => DomainInfo) private domains;

    address public owner;
    uint256 public registrationPrice;
    uint256 public renewalCoefficient;

    // Events for logging important actions
    event DomainRegistered(string domain, address owner, uint256 price, uint256 years);
    event DomainRenewed(string domain, address owner, uint256 price, uint256 years);
    event Withdrawal(address to, uint256 amount);
    event RegistrationPriceChanged(uint256 newPrice);
    event RenewalCoefficientChanged(uint256 newCoefficient);

    // Constructor to set the initial owner, registration price, and renewal coefficient
    constructor(uint256 _registrationPrice, uint256 _renewalCoefficient) {
        owner = msg.sender;
        registrationPrice = _registrationPrice;
        renewalCoefficient = _renewalCoefficient;
    }

    // Modifier to restrict access to the contract owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the contract owner can call this function");
        _;
    }

    // Function to set the registration price (only callable by the owner)
    function setRegistrationPrice(uint256 _newPrice) public onlyOwner {
        registrationPrice = _newPrice;
        emit RegistrationPriceChanged(_newPrice);
    }

    // Function to set the renewal coefficient (only callable by the owner)
    function setRenewalCoefficient(uint256 _newCoefficient) public onlyOwner {
        renewalCoefficient = _newCoefficient;
        emit RenewalCoefficientChanged(_newCoefficient);
    }

    // Function to register a new domain
    function registerDomain(string memory domain, uint256 years) public payable {
        require(years >= 1 && years <= 10, "Registration years must be between 1 and 10");
        require(isDomainAvailable(domain), "Domain is not available");

        uint256 totalPrice = registrationPrice * years;
        require(msg.value >= totalPrice, "Insufficient payment for domain registration");

        domains[domain] = DomainInfo({
            owner: msg.sender,
            registrationTime: block.timestamp,
            expirationTime: block.timestamp + (years * 365 days),
            price: totalPrice,
            registrationYears: years
        });

        emit DomainRegistered(domain, msg.sender, totalPrice, years);
    }

    // Function to renew an existing domain
    function renewDomain(string memory domain, uint256 years) public payable {
        require(years >= 1 && years <= 10, "Renewal years must be between 1 and 10");
        require(domains[domain].owner == msg.sender, "You are not the owner of this domain");
        require(block.timestamp <= domains[domain].expirationTime, "Domain has expired");

        uint256 renewalPrice = (registrationPrice * renewalCoefficient * years) / 100;
        require(msg.value >= renewalPrice, "Insufficient payment for domain renewal");

        domains[domain].expirationTime += years * 365 days;
        domains[domain].registrationYears += years;

        emit DomainRenewed(domain, msg.sender, renewalPrice, years);
    }

    // Function to check if a domain is available
    function isDomainAvailable(string memory domain) public view returns (bool) {
        return domains[domain].owner == address(0) || block.timestamp > domains[domain].expirationTime;
    }

    // Function to get the owner of a domain
    function getDomainOwner(string memory domain) public view returns (address) {
        require(block.timestamp <= domains[domain].expirationTime, "Domain has expired");
        return domains[domain].owner;
    }

    // Function to withdraw funds from the contract (only callable by the owner)
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        (bool success, ) = owner.call{value: balance}("");
        require(success, "Withdrawal failed");

        emit Withdrawal(owner, balance);
    }
}
