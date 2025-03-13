// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Sign {
    /**
     * Verifies a signature for a given message and signer.
     * 
     * @param _signer The expected signer of the message.
     * @param _message The message that was signed.
     * @param _sig The signature to verify.
     * 
     * @return True if the signature is valid for the given signer and message.
     */
    function verify(address _signer, string memory _message, bytes memory _sig) external pure returns(bool) {
        bytes32 msgHash = messageHash(_message);
        bytes32 signedMsgHash = EthSignedMessageHash(msgHash);
        return recover(signedMsgHash, _sig) == _signer;
    }

    /**
     * Computes the hash of a message.
     * 
     * @param _msg The message to hash.
     * 
     * @return The hash of the message.
     */
    function messageHash(string memory _msg) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(_msg));
    }

    /**
     * Computes the Ethereum signed message hash.
     * 
     * @param _msgHash The hash of the message.
     * 
     * @return The Ethereum signed message hash.
     */
    function EthSignedMessageHash(bytes32 _msgHash) public pure returns(bytes32) {
        return keccak256(abi.encodePacked(
            "\x19Ethereum Signed Message:\n32", _msgHash
        ));
    }

    /**
     * Recovers the signer of a message from a signature.
     * 
     * @param _ethSignedMsgHash The Ethereum signed message hash.
     * @param _sig The signature to recover from.
     * 
     * @return The signer of the message.
     */
    function recover(bytes32 _ethSignedMsgHash, bytes memory _sig) public pure returns(address) {
        (bytes32 r, bytes32 s, uint8 v) = _splitSig(_sig);
        return ecrecover(_ethSignedMsgHash, v, r, s);
    }

    /**
     * Splits a signature into its components (r, s, v).
     * 
     * @param _sig The signature to split.
     * 
     * @return The components of the signature.
     */
    function _splitSig(bytes memory _sig) internal pure returns(bytes32 r, bytes32 s, uint8 v) {
        require(_sig.length == 65, "invalid signature");
        assembly {
            r := mload(add(_sig, 32))
            s := mload(add(_sig, 64))
            v := byte(0, mload(add(_sig, 96)))
        }
    }
}
