pragma solidity ^0.4.24;

import "./ERC20.sol";
import "./SafeMath.sol";

contract Somchioce is ERC20 {
    using SafeMath for uint256;
    
    mapping(address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private allowed;
    
    uint256 private totalSupply_;
    
    function totalSupply() public view returns (uint256) {
        return totalSupply_;
    }
    
    function balanceOf(address _who) public view returns (uint256) {
        return balances[_who];
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256) {
        return allowed[_owner][_spender];
    }
    
    function transfer(address _to, uint256 _value) public returns (bool) {
        require(_value <= balances[msg.sender]);
        require(_to != address(0));
        balances[msg.sender] = balances[msg.sender].sub(_value); // ลดจำนวน token ของผู้ส่ง
        balances[_to] = balances[_to].add(_value); // เพิ่มจำนวน token ของผู้รับ
        emit Transfer(msg.sender, _to, _value); // Call event
        return true;
    }
    
    function approve(address _spender, uint256 _value) public returns (bool) {
        allowed[msg.sender][_spender] = _value; // set ว่าcontract นี้มีสิทธิโอน token จาก address นี้จำนวนเท่าไหร่
        emit Approval(msg.sender, _spender, _value);
        return true;
    }
    
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require(_value <= balances[_from]);
        require(_value <= allowed[_from][msg.sender]);
        require(_to != address(0));
    
        balances[_from] = balances[_from].sub(_value);
        balances[_to] = balances[_to].add(_value);
        allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
        emit Transfer(_from, _to, _value);
        return true;
    }
    
}
