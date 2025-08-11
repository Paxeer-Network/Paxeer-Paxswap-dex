// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./interfaces/IERC20.sol";

contract DewToken is IERC20 {
    string public constant name = "DewSwap Token";
    string public constant symbol = "DEW";
    uint8 public constant decimals = 18;
    uint256 public totalSupply;
    
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    address public owner;
    
    modifier onlyOwner() {
        require(msg.sender == owner, "DewToken: Only owner can call this function");
        _;
    }
    
    constructor(uint256 _totalSupply) {
        owner = msg.sender;
        totalSupply = _totalSupply * 10**decimals;
        balanceOf[msg.sender] = totalSupply;
        emit Transfer(address(0), msg.sender, totalSupply);
    }
    
    function transfer(address to, uint256 amount) external override returns (bool) {
        return _transfer(msg.sender, to, amount);
    }
    
    function transferFrom(address from, address to, uint256 amount) external override returns (bool) {
        uint256 currentAllowance = allowance[from][msg.sender];
        require(currentAllowance >= amount, "DewToken: Transfer amount exceeds allowance");
        
        if (currentAllowance != type(uint256).max) {
            allowance[from][msg.sender] = currentAllowance - amount;
        }
        
        return _transfer(from, to, amount);
    }
    
    function approve(address spender, uint256 amount) external override returns (bool) {
        allowance[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }
    
    function _transfer(address from, address to, uint256 amount) internal returns (bool) {
        require(from != address(0), "DewToken: Transfer from zero address");
        require(to != address(0), "DewToken: Transfer to zero address");
        require(balanceOf[from] >= amount, "DewToken: Transfer amount exceeds balance");
        
        balanceOf[from] -= amount;
        balanceOf[to] += amount;
        
        emit Transfer(from, to, amount);
        return true;
    }
    
    function mint(address to, uint256 amount) external onlyOwner {
        totalSupply += amount;
        balanceOf[to] += amount;
        emit Transfer(address(0), to, amount);
    }
    
    function burn(uint256 amount) external {
        require(balanceOf[msg.sender] >= amount, "DewToken: Burn amount exceeds balance");
        balanceOf[msg.sender] -= amount;
        totalSupply -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }
}
