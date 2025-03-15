// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Owned.sol";

contract Demo is Owned {
    function withdraw(address payable _to) public onlyOwner {
        address thisContract = address(this);
        (bool sent, ) = _to.call{value: address(this).balance}("");
        require(sent, "Failed to send Ether");
    }

    function parentFunc() public override pure returns(uint) {
        return 100;
    }
}
