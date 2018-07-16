pragma solidity ^0.4.22;

contract Greeter {
    string greeting;
    address owner;
    
    constructor(string _greeting) public {
        greeting = _greeting;
        owner = msg.sender;
    }
    
    modifier onlyOwner(){
        require(msg.sender == owner, "You aren't contract owner. ");
        _;
    }
    
    function sayHello() public view returns(string) {
        if(msg.sender == owner) {
            return "Hello Daddy";
        }
        else{
            return greeting;
        }
    }
    function setGreeting(string _newGreeting) public onlyOwner {
        greeting = _newGreeting;
    }
}