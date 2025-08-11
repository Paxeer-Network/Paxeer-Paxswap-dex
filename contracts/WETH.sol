// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import "./interfaces/IERC20.sol";
import "./interfaces/IWETH.sol";

contract WETH is IERC20, IWETH {
    string public constant name = "Wrapped Ether";
    string public constant symbol = "WETH";
    uint8 public constant decimals = 18;
    
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;
    
    event Deposit(address indexed dst, uint256 wad);
    event Withdrawal(address indexed src, uint256 wad);
    
    function totalSupply() public view override returns (uint256) {
        return address(this).balance;
    }
    
    function deposit() public payable override {
        balanceOf[msg.sender] += msg.value;
        emit Deposit(msg.sender, msg.value);
        emit Transfer(address(0), msg.sender, msg.value);
    }
    
    function withdraw(uint256 wad) public override {
        require(balanceOf[msg.sender] >= wad, "WETH: Insufficient balance");
        balanceOf[msg.sender] -= wad;
        payable(msg.sender).transfer(wad);
        emit Withdrawal(msg.sender, wad);
        emit Transfer(msg.sender, address(0), wad);
    }
    
    function approve(address guy, uint256 wad) public override returns (bool) {
        allowance[msg.sender][guy] = wad;
        emit Approval(msg.sender, guy, wad);
        return true;
    }
    
    function transfer(address dst, uint256 wad) public override(IERC20, IWETH) returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }
    
    function transferFrom(address src, address dst, uint256 wad) public override returns (bool) {
        require(balanceOf[src] >= wad, "WETH: Insufficient balance");
        
        if (src != msg.sender && allowance[src][msg.sender] != type(uint256).max) {
            require(allowance[src][msg.sender] >= wad, "WETH: Insufficient allowance");
            allowance[src][msg.sender] -= wad;
        }
        
        balanceOf[src] -= wad;
        balanceOf[dst] += wad;
        
        emit Transfer(src, dst, wad);
        return true;
    }
    
    receive() external payable {
        deposit();
    }
    
    fallback() external payable {
        deposit();
    }
}
