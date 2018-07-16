pragma solidity ^0.4.22;

contract Lottery {
    uint price = 0.1 ether;
    uint userLimit = 10;
    uint public usersCount = 0;
    address[] playersArray = new address[](userLimit);
    uint randomNumber;
    uint randNonce = 0;
    uint winner;
    
    
    function join() public payable{
        require(msg.value == price, "If you want join, pay 0.1 ether");
        require(checkingUser(), "You can't take part in this lottery. ");
        playersArray[usersCount] = msg.sender;
        usersCount++;
        if(usersCount == userLimit){
            selectWinner();
        }
    }
    
    function checkingUser() private view returns(bool){
        for(uint i = 0; i < playersArray.length; i++)
        {
            if(msg.sender == playersArray[i])
                return false;
        }
        return true;
    }
    
    function selectWinner() private{
        require(usersCount == 10, "Waiting for more users");
        winner = basicRandom();
        playersArray[winner].transfer(address(this).balance);
        usersCount = 0;
    }
    
    function basicRandom() private returns(uint) {
        randomNumber = uint(keccak256(abi.encodePacked(now, randNonce, blockhash(block.number-1)))) % 10;
        randNonce++;
        return randomNumber;
    }
}