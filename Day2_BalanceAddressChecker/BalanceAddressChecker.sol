pragma solidity ^0.4.22;
contract BalanceAddressChecker{
    address owner;

    constructor() public {
        owner = msg.sender;
    }

    function getContractAddress() public view returns(address) {
        return this;
    }

    function getContractBalance() public view returns(uint) {
        return this.balance;
    }

    function getSenderAddress() public view returns(address) {
        return msg.sender;
    }

    function getOwnerAddress() public view returns(address) {
        return owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You aren't contract owner.");
        _;
    }

    function getSenderBalance() public view returns(uint) {
        return msg.sender.balance;
    }

    function getOwnerBalance() public view onlyOwner returns(uint) {
        return owner.balance;
    }

}