// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

//Inherit

import "./Hero.sol";

contract Mage is Hero {

}

contract Warrior is Hero {

}

//Constructor Args
import "./Hero.sol";

contract Mage is Hero(50) {

}

contract Warrior is Hero(200) {

}

//Virtual Override
contract Mage is Hero(50) {
    function attack(Enemy _enemy) override public {
        _enemy.takeAttack(AttackTypes.Spell);
    }
}

contract Warrior is Hero(200) {
    function attack(Enemy _enemy) override public {
        _enemy.takeAttack(AttackTypes.Brawl);
    }
}

//Super
contract Mage is Hero {
    constructor() Hero(50) {}

    function attack(Enemy _enemy) override public {
        super.attack(_enemy);
        _enemy.takeAttack(AttackTypes.Spell);
    }
}

contract Warrior is Hero {
    constructor() Hero(200) {}

    function attack(Enemy _enemy) override public {
        super.attack(_enemy);
        _enemy.takeAttack(AttackTypes.Brawl);
    }
}

//Ownable
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Ownable: caller is not the owner");
        _;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

//Multiple Inheritance
contract Ownable {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == _owner, "Ownable: caller is not the owner");
        _;
    }

    function owner() public view returns (address) {
        return _owner;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

contract Transferable is Ownable {
    function transfer(address newOwner) public onlyOwner {
        transferOwnership(newOwner);
    }
}
