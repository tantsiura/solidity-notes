// SPDX-License-Identifier: MIT

//Booleans
pragma solidity ^0.8.20;

contract Contract {
	bool public a = true;
    bool public b = false;
}

//Unsigned Integers
contract Contract {
    uint8 public a = 255;
    uint16 public b = 256;
    uint256 public sum = a + b;
}

//Signed Integers
contract Contract {
    int8 public a = 15;
    int8 public b = -15;
    int16 public difference = a - b;
}

//String Literals
contract Contract {
    bytes32 public msg1 = "Hello World";
    string public msg2 = "This is a long string that requires more than 32 bytes of storage. It can be used to demonstrate the use of a public string storage variable in Solidity.";
}

//Enum
contract Contract {
    enum Foods { Apple, Pizza, Bagel, Banana }
	Foods public food1 = Foods.Apple;
	Foods public food2 = Foods.Pizza;
	Foods public food3 = Foods.Bagel;
	Foods public food4 = Foods.Banana;
}
