// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Import OpenZeppelin's Ownable contract for the onlyOwner modifier
import "@openzeppelin/contracts/access/Ownable.sol";

// Base contract for all records
contract BaseRecord {
    uint256 public timeOfCreation;

    // Constructor to set the creation time
    constructor() {
        timeOfCreation = block.timestamp;
    }

    // Function to get the record type
    virtual function getRecordType() public pure virtual returns (string memory) {}
}

// Contract for string type records
contract StringRecord is BaseRecord {
    string public record;

    // Constructor to initialize the record with a string value
    constructor(string memory _record) {
        record = _record;
    }

    // Function to update the record value
    function setRecord(string memory _newRecord) public {
        record = _newRecord;
    }

    // Function to get the record type
    function getRecordType() public pure override returns (string memory) {
        return "string";
    }
}

// Contract for address type records
contract AddressRecord is BaseRecord {
    address public record;

    // Constructor to initialize the record with an address value
    constructor(address _record) {
        record = _record;
    }

    // Function to update the record value
    function setRecord(address _newRecord) public {
        record = _newRecord;
    }

    // Function to get the record type
    function getRecordType() public pure override returns (string memory) {
        return "address";
    }
}

// Contract for ENS type records
contract EnsRecord is BaseRecord {
    string public domain;
    address public owner;

    // Constructor to initialize the record with domain and owner
    constructor(string memory _domain, address _owner) {
        domain = _domain;
        owner = _owner;
    }

    // Function to update the owner of the ENS record
    function setOwner(address _newOwner) public {
        owner = _newOwner;
    }

    // Function to get the record type
    function getRecordType() public pure override returns (string memory) {
        return "ens";
    }
}

// Contract for storing records
contract RecordsStorage is Ownable {
    // Array to store all created records
    BaseRecord[] public records;

    // Mapping to store authorized factories
    mapping(address => bool) public factories;

    // Function to add a record to the storage
    function addRecord(BaseRecord _record) public {
        require(factories[msg.sender], "Only authorized factories can add records");
        records.push(_record);
    }

    // Function to add a factory to the list of authorized factories
    function addFactory(address _factory) public onlyOwner {
        factories[_factory] = true;
    }
}

// Base contract for record factories
contract BaseFactory {
    RecordsStorage public storage;

    // Constructor to set the storage contract
    constructor(address _storage) {
        storage = RecordsStorage(_storage);
    }

    // Internal function to add a record to the storage
    function onRecordAdding(BaseRecord _record) internal {
        storage.addRecord(_record);
    }
}

// Factory for StringRecord
contract StringFactory is BaseFactory {
    constructor(address _storage) BaseFactory(_storage) {}

    // Function to create and add a StringRecord
    function addRecord(string memory _record) public {
        StringRecord newRecord = new StringRecord(_record);
        onRecordAdding(newRecord);
    }
}

// Factory for AddressRecord
contract AddressFactory is BaseFactory {
    constructor(address _storage) BaseFactory(_storage) {}

    // Function to create and add an AddressRecord
    function addRecord(address _record) public {
        AddressRecord newRecord = new AddressRecord(_record);
        onRecordAdding(newRecord);
    }
}

// Factory for EnsRecord
contract EnsFactory is BaseFactory {
    constructor(address _storage) BaseFactory(_storage) {}

    // Function to create and add an EnsRecord
    function addRecord(string memory _domain, address _owner) public {
        EnsRecord newRecord = new EnsRecord(_domain, _owner);
        onRecordAdding(newRecord);
    }
}
