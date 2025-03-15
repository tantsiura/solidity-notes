// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./Owned.sol";

contract Demo is Owned {

    function withdraw(address payable _to) public onlyOwner {
        addres thisContacrt = address(this);
        _to.transfer(thisContacrt.balance);
    }

    function parentFunc() public override pure returns(uint) {
        return 100;
    }
}
