// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Crypton is Ownable {

    address[] public _investors;
    mapping(address => uint256) public _amount;
    
    constructor() {
    }    

    function deposit() public payable {
        require(msg.value > 0, "Incorrect value");
        _investors.push(msg.sender);
        _amount[msg.sender] = _amount[msg.sender] + msg.value;
    }
 
    function withdraw(address payable to, uint256 amount) public payable onlyOwner {
        require(amount <= address(this).balance, "Insufficient funds");
        payable(to).transfer(amount);
    }

    function getAmount(address investor) public view returns(uint256){
        return _amount[investor];
    }

}