// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;

import "./SharedWallet.sol";

contract Wallet is SharedWallet {
    // Event emitted when money is withdrawn
    event MoneyWithdrawn(address indexed _to, uint _amount);

    // Event emitted when money is received
    event MoneyReceived(address indexed _from, uint _amount);

    // Function to withdraw money, restricted by ownerOrWithinLimits modifier
    function withdrawMoney(uint _amount) public ownerOrWithinLimits(_amount) {
        require(_amount <= address(this).balance, "Not enough funds to withdraw!");
        
        if(!isOwner()) {
            deduceFromLimit(_msgSender(), _amount);
        }
        
        address payable _to = payable(_msgSender());
        _to.transfer(_amount);
        
        emit MoneyWithdrawn(_to, _amount);
    }

    // Function to send Ether to the contract
    function sendToContract() public payable {
        address payable _to = payable(this);
        _to.transfer(msg.value);
        
        emit MoneyReceived(_msgSender(), msg.value);
    }

    // Receive function to handle incoming Ether without specifying a function
    receive() external payable {
        emit MoneyReceived(_msgSender(), msg.value);
    }

    // Fallback function for compatibility
    fallback() external payable {
        emit MoneyReceived(_msgSender(), msg.value);
    }

    // Function to get the contract balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }
}
