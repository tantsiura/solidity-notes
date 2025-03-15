// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IDemo {
    function pay() external payable;
}

contract Other {
    address public sender;
    uint public amount;

    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    function callPay(address _demo) external payable {
        (bool result) = _demo.delegetecall(
            // abi.encodeWithSignature(
            //     "pay(string)"
            // )
            abi.encodeWithSelector(
                IDemo.pay.Selector;
            )
        );
        require(result, "failed");
    }

}
