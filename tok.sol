// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;
contract Token1 {

string public name;
string public symbol;
uint16 public constant InitialTotalSupply = 1000; 
mapping(address => uint256) internal balances;
mapping(address => mapping(address => uint256)) internal allowances;
event Transfer(address indexed from, address indexed to, uint value, uint time);
event Approval(address indexed owner, address indexed recipient, uint256 _value, uint256 time);

    constructor(){
        
        balances[msg.sender] = InitialTotalSupply;
        name = "TOKEN1";
        symbol = "TK1";
    }

    function totalSupply() public view returns (uint256 _totalSupply) {
        _totalSupply = InitialTotalSupply;
        return _totalSupply;
    }

    function balanceOf(address account) public view returns(uint256){ 
        return balances[account];
    
    }
    
    function transfer(address recipient, uint256 ammount) public returns (bool success){
        require(ammount <= balances[msg.sender], "Insuffiecient funds");
        balances[msg.sender]-=ammount;
        balances[recipient]+=ammount;
        emit Transfer(msg.sender, recipient, ammount, block.timestamp);
        return true;
    }

}

contract Token2 is Token1{

    function approve(address recipient, uint256 ammount) public returns (bool success){
        if (allowances[msg.sender][recipient] <= ammount){
        emit Approval(msg.sender, recipient, ammount, block.timestamp);
        return true;
        }
    }

    function allowance(address owner, address spender) view public returns (uint256){
        allowances[owner][msg.sender];
        allowances[spender][msg.sender];
        return allowances[owner][spender];
        
        
    }

    function transferFrom(address sender, address recipient, uint256 ammount) public returns (bool success){
        if (allowances[recipient][msg.sender] >= ammount && balances[sender] >= ammount){
        
        balances[sender]-=ammount;
        balances[recipient]+=ammount;
        allowances[sender][msg.sender] -=ammount;
        emit Transfer(msg.sender, recipient, ammount, block.timestamp);
        return true; 
        }
        
    }

}

contract Token3Optional is Token2 {

    function getSymbol() view public returns (string memory){
        return symbol;
    }

    function getName() view public returns (string memory){
        return name;
    }

}
