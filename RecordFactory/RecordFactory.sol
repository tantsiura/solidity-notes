// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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

// Factory contract to manage records
contract RecordFactory {
    // Array to store all created records
    BaseRecord[] public records;

    // Function to add a string type record
    function addRecord(string memory _record) public {
        StringRecord newRecord = new StringRecord(_record);
        records.push(newRecord);
    }

    // Function to add an address type record
    function addRecord(address _record) public {
        AddressRecord newRecord = new AddressRecord(_record);
        records.push(newRecord);
    }
}
