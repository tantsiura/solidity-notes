// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/**
 * This contract demonstrates basic encoding and hashing operations.
 */
contract Demo {
    /**
     * This function generates a Keccak-256 hash from the encoded input parameters.
     * 
     * @param str1 The string to be encoded and hashed.
     * @param int1 The integer to be encoded and hashed.
     * @return The Keccak-256 hash of the encoded input.
     */
    function doHash(string memory str1, uint int1) public pure returns(bytes32) {
        // Encode the input parameters using abi.encode and then generate a Keccak-256 hash.
        return keccak256(doEncode(str1, int1));
    }
    
    /**
     * This function encodes the input string and integer into bytes.
     * 
     * @param str1 The string to be encoded.
     * @param int1 The integer to be encoded.
     * @return The encoded bytes.
     */
    function doEncode(string memory str1, uint int1) public pure returns(bytes memory) {
        // Use abi.encode to encode the input parameters into bytes.
        bytes memory res1 = abi.encode(str1, int1);
        // Alternatively, you can use abi.encodePacked for more compact encoding.
        // bytes memory res2 = abi.encodePacked(str1, int1);
        return res1;
    }
}
