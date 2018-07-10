pragma solidity ^0.4.23;

contract BasicRandom {
    uint randNonce = 0;
    uint public randomNumber;
    
    function getRandomNumber() public {
        randomNumber = uint(keccak256(abi.encodePacked(now, msg.sender, randNonce, blockhash(block.number-1)))) % 100;
        randNonce++;
    }
}