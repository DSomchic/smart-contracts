pragma solidity ^0.4.24;

import "./somchoice.sol";

contract Somchic is Somchoice {
    
    mapping(address => bool) private isStore;
    
    function buyToken () payable public returns (bool){
        require(msg.value > 0);
        uint256 amount = 10000 * msg.value;
        isStore[msg.sender] = true;
        balances[msg.sender] = balances[msg.sender].add(amount);
        return true;
    }
}
