pragma solidity ^0.4.22;

contract Lottery {
    uint price = 0.1 ether;
    uint userLimit = 10;
    uint public usersCount = 0;
    address[] players = new address[](userLimit);
    uint randNonce = 0;
    
    function join() public payable oneJoinOnly validFee {
        players[usersCount++] = msg.sender;
        if(usersCount == userLimit){
            rewardWinner();
            resetLottery();
        }
    }
    
    modifier validFee() {
        require(msg.value == price, "If you want join, pay 0.1 ether"); 
        _;
    }

    modifier oneJoinOnly() {
        bool firstTime = true;
        for(uint i = 0; i < players.length; i++)
        {
            if(msg.sender == players[i])
                firstTime = false;
        }
        require(firstTime, "You can't take part in this lottery. ");
        _;
    }
    
    function rewardWinner() private {
        uint winnerNumber = basicRandom();
        players[winnerNumber].transfer(address(this).balance);
    }

    function resetLottery() private {
        usersCount = 0;
        for(uint i = 0; i < players.length; i++)
        {
            players[i] = address(0);
        }
    }
    
    function basicRandom() private returns(uint) {
        uint randomNumber = uint(keccak256(abi.encodePacked(now, randNonce, blockhash(block.number-1)))) % 10;
        randNonce++;
        return randomNumber;
    }
}