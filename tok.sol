// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;
contract Token1 {

string public _name;
string public _symbol;
uint16 public constant InitialTotalSupply = 1000; 
mapping(address => uint256) internal balances;
mapping(address => mapping(address => uint256)) internal allowances;
mapping(address => bool) internal frozen;
event Transfer(address indexed from, address indexed to, uint value, uint time);
event Approval(address indexed owner, address indexed recipient, uint256 _value, uint256 time);
event Frozen(address indexed account, bool yes, uint256 time);

    address owner;

    constructor(){
        owner = msg.sender;
        balances[msg.sender] = InitialTotalSupply;
        _name = "TOKEN1";
        _symbol = "TK1";
    }

    modifier onlyOwner{
        require(msg.sender == owner);
        _;
    }

    function totalSupply() external view returns (uint256 _totalSupply) {
        _totalSupply = InitialTotalSupply;
        return _totalSupply;
    }

    function balanceOf(address account) external view returns(uint256){ 
        return balances[account];
    
    }
    
    function transfer(address recipient, uint256 ammount) external returns (bool success){
        require(ammount <= balances[msg.sender], "Insuffiecient funds");
        require(!frozen[msg.sender], "Your account is frozen");
        balances[msg.sender]-=ammount;
        balances[recipient]+=ammount;
        emit Transfer(msg.sender, recipient, ammount, block.timestamp);
        return true;
    }

}

contract Token2 is Token1{

    function approve(address recipient, uint256 ammount) external returns (bool success){
        if (allowances[msg.sender][recipient] <= ammount){
        emit Approval(msg.sender, recipient, ammount, block.timestamp);
        return true;
        }
    }

    function allowance(address owner, address spender) view external returns (uint256){
        allowances[owner][msg.sender];
        allowances[spender][msg.sender];
        return allowances[owner][spender];
        
        
    }

    function transferFrom(address sender, address recipient, uint256 ammount) external returns (bool success){
        if (allowances[recipient][msg.sender] >= ammount && balances[sender] >= ammount){
        require(!frozen[sender], "The allowance account is frozen");
        balances[sender]-=ammount;
        balances[recipient]+=ammount;
        allowances[sender][msg.sender] -=ammount;
        emit Transfer(msg.sender, recipient, ammount, block.timestamp);
        return true; 
        }
        
    }

}

contract Token3Optional is Token2 {

    function symbol() view external returns (string memory){
        return _symbol;
    }


    function name() view external returns (string memory){
        return _name;
    }

    function freezeaccount(address freeze, bool yes) external onlyOwner {
        frozen[freeze] = yes;
        emit Frozen(freeze, yes, block.timestamp);
    
    }

}
