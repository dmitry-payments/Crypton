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

// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./IMyERC20.sol";

contract MyERC20 is IMyERC20 {
    
    mapping(address => uint256) public _balance;
    uint256 public _totalSupply;
    mapping(address => mapping (address => uint256)) public _allowances;
    string public _name;
    string public _symbol;

    constructor(string memory name, string memory symbol) {
        _name = name;
        _symbol = symbol;
    }

    function approve(address spender, uint256 amount) public override returns (bool success) {
        require(_balance[msg.sender] >= amount, "Insufficient amount");
        _allowances[msg.sender][spender] = amount;
        return true;
    }

    function transfer(address receiver, uint256 amount) public override returns (bool success) {
        require(_balance[msg.sender] >= amount, "Insufficient amount");
        _balance[msg.sender] -= amount;
        _balance[receiver] += amount;
        return true;
    }

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;


interface IMyERC20 {
    function name() public view returns (string);
    function symbol() public view returns (string);
    function decimals() public view returns (uint8);
    function totalSupply() public view returns (uint256);
    function balanceOf(address _owner) public view returns (uint256 balance);
    function allowance(address _owner, address _spender) public view returns (uint256 remaining);

    function transfer(address _to, uint256 _value) public returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success);
    function approve(address _spender, uint256 _value) public returns (bool success);

}
    

}