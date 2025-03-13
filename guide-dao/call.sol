// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Other {
    function payDemo(Demo _demo) public payable {
        require(msg.value > 0, "Value must be greater than zero");
        require(address(_demo) != address(0), "Demo contract address cannot be zero");
        
        // Call pay function on Demo contract with the current sender and the value sent with this transaction
        (bool success, ) = _demo.pay{value: msg.value}(msg.sender);
        require(success, "Call to Demo contract failed");
    }
}

contract Demo {
    mapping(address => uint) public payments;

    function pay(address _payer) public payable {
        require(_payer != address(0), "Payer address cannot be zero");
        require(msg.value > 0, "Value must be greater than zero");
        
        payments[_payer] = msg.value;
    }
}
