pragma solidity ^0.4.24;

import "./somchoice.sol";

contract Somchic is Somchoice {
    
    mapping(address => bool) private isStore;
    
    event BuyToken(address buyer, uint256 amount, uint256 tokenBalance);
    event SellToken(uint256 weiReceived, uint256 tokenBalance);
    
    function buyToken () payable public returns (bool){
        require(msg.value > 0);
        uint256 amount = 10000 * msg.value;
        isStore[msg.sender] = true;
        balances[msg.sender] = balances[msg.sender].add(amount);
        emit BuyToken(msg.sender, amount, balances[msg.sender]);
        return true;
    }
    
    function sellToken (uint256 _amount) public returns (bool) {
        require(isStore[msg.sender] == true);
        uint256 amountWei = _amount / 10000;
        _burnToken(msg.sender, _amount);
        msg.sender.transfer(amountWei);
        emit SellToken(amountWei, balances[msg.sender]);
        return true;
    }
    
    function _burnToken (address _storeAddr, uint256 _amount) private {
        require(_storeAddr == msg.sender);
        balances[_storeAddr] = balances[_storeAddr].sub(_amount);
    }
}
