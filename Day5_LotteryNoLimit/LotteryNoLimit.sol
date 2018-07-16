pragma solidity ^0.4.22;

contract LotteryNoLimit {
    uint price = 0.1 ether;
    uint public usersCount = 0;
    uint randNonce = 0;
    address owner;
    mapping(uint => address) players;
    
    constructor() public {
        owner = msg.sender;
    }

    modifier validFee() {
        require(msg.value == price, "If you want join, pay 0.1 ether"); 
        _;
    } 

    modifier onlyOwner() {
        require(msg.sender == owner, "You aren't contract owner. ");
        _;
    }

    function join() public payable validFee {
        players[usersCount++] = msg.sender;
    }
    
    function endLottery() public onlyOwner {
        rewardWinner();
        resetLottery();
    }
    
    function rewardWinner() private {
        uint winnerNumber = basicRandom();
        players[winnerNumber].transfer(address(this).balance);
    }
    
    function resetLottery() private {
        for(uint i = 0; i < usersCount; i++)
        {
            delete players[i];
        }
        usersCount = 0;
    }
    
    function basicRandom() private returns(uint) {
        uint randomNumber = uint(keccak256(abi.encodePacked(now, randNonce, blockhash(block.number-1)))) % usersCount;
        randNonce++;
        return randomNumber;
    }
}