// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

//Call Function
interface IHero {
    function alert() external;
}

contract Sidekick {
    function sendAlert(address heroAddress) external {
        IHero hero = IHero(heroAddress);
        hero.alert();
    }
}

//Signature
contract Sidekick {
    function sendAlert(address hero) external {
        bytes4 signature = bytes4(keccak256("alert()"));

        (bool success, ) = hero.call(abi.encodePacked(signature));

        require(success);
    }
}

//With Signature
contract Sidekick {
    function sendAlert(address hero, uint enemies, bool armed) external {
        (bool success, ) = hero.call(
            abi.encodeWithSignature("alert(uint256,bool)", enemies, armed)
        );

        require(success);
    }
}

//Arbitrary Alert
contract Sidekick {
    function relay(address hero, bytes memory data) external {
        (bool success, ) = hero.call(data);
        require(success, "Relay failed");
    }
}

//Fallback
contract Sidekick {
    function makeContact(address hero) external {
        (bool success, ) = hero.call(abi.encodeWithSignature(""));
        require(success, "Failed to trigger fallback function");
    }
}
