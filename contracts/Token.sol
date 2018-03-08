pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';
//import './utils/';
//using SafeMath for uint256;

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {
	// YOUR CODE HERE
  uint256 public totalSupply;
  mapping(address => uint256) balances;
  mapping(address => mapping (address => uint256)) allowed;

  function token(uint256 initAmount){
    totalSupply = initAmount;
  }

  /// @param _owner The address from which the balance will be retrieved
  /// @return The balance
  function balanceOf(address _owner) constant returns (uint256 balance){
    return balances[msg.sender];
  }

  /// @notice send `_value` token to `_to` from `msg.sender`
  /// @param _to The address of the recipient
  /// @param _value The amount of token to be transferred
  /// @return Whether the transfer was successful or not
  function transfer(address _to, uint256 _value) returns (bool success){
      //balances[msg.sender] = balances[msg.sender].sub(_value);
      balances[msg.sender] -= _value;
      //balances[_to] = balances[_to].add(_value);
      balances[_to] += _value;
      Transfer(msg.sender, _to, _value);
      return true;

  }

  /// @notice send `_value` token to `_to` from `_from` on the condition it is approved by `_from`
  /// @param _from The address of the sender
  /// @param _to The address of the recipient
  /// @param _value The amount of token to be transferred
  /// @return Whether the transfer was successful or not
  function transferFrom(address _from, address _to, uint256 _value) returns (bool success){
    if(allowed[_from][_to] >= _value){

      //balances[_from] = balances[_from].sub(_value);
      //balances[_to] = balances[_to].add(_value);
      //allowed[_from][_to] = allowed[_from][_to].sub(_value);
      balances[_from] -= _value;
      balances[_to] += _value;
      allowed[_from][_to] -= _value;
      Transfer(_from, _to, _value);
      return true;
    }
    return false;

  }

  /// @notice `msg.sender` approves `_spender` to spend `_value` tokens
  /// @param _spender The address of the account able to transfer the tokens
  /// @param _value The amount of tokens to be approved for transfer
  /// @return Whether the approval was successful or not
  function approve(address _spender, uint256 _value) returns (bool success){
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);

    return true;
  }

  /// @param _owner The address of the account owning tokens
  /// @param _spender The address of the account able to transfer the tokens
  /// @return Amount of remaining tokens allowed to spent
  function allowance(address _owner, address _spender) constant returns (uint256 remaining){
    return allowed[_owner][_spender];
  }

  event Transfer(address indexed _from, address indexed _to, uint256 _value);
  event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
