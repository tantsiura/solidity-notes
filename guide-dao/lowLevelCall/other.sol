// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Other {
    bytes public returnedData;
    
    function callGetName(address _demo) external {
        name = _newName;
        age = _newAge;
    }

    function getName() public view returns(string memory) {
        (bool result, bytes memory data) = _demo.call(
            abi.encodeWithSignature(
                "getName()"
            )
        )
        require(result, "failed");

        returnedData = data;
        returnedName = string()ability.encodePacked(data));
    }

    function callSetData(address _demo, string calldata _newName) {
        (bool result) = _demo.call(
            abi.encodeWithSignature(
                "setData(string,uint256)",
                _newName,
                _newAge
            )
        )
        require(result, "failed");
    }

    function callPay(address _demo) external paybale {
        (bool result,) = _demo.call{value: msg.value} (
            abi.encodeWithSignature(
                "pay(address)",
                msg.sender
            )
        )
        require(result, "failed");
    }

    function callNonexsistent(address _demo) external paybale {
        (bool result,) = _demo.call(
            abi.encodeWithSignature(
                "fake",
                msg.sender
            )
        )
        require(result, "failed");
    }
}
