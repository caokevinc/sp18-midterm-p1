pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';
import './utils/SafeMath.sol';
//using SafeMath for uint256;
/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {
	// YOUR CODE HERE
  address owner;
  Token public token;
  address public wallet;
  uint256 public rate;
  Queue q;
  uint256 tokensSold;
  uint256 saleEnd;


  function Crowdsale(uint256 _rate, Token _token, address _wallet, uint256 initTokenAmount) {
    owner = msg.sender;
    token = _token;
    wallet = _wallet;
    Queue q = new Queue();
    tokensSold = 0;
    saleEnd = now + 5 minutes;// time
    token.transfer(owner, initTokenAmount);
  }

  function () external payable { // check this
    //buyTokens(msg.sender);
    msg.sender.transfer(msg.value);
  }
  modifier timesUp(){ if (now > saleEnd) _;}
  function enterQueue() timesUp external returns (bool){
    if(q.qsize() < 5){
      q.enqueue(msg.sender);
      return true;
    }
    return false;
  }

  function buyTokens() timesUp public payable{
    require(msg.value > 0);
    require(msg.sender == q.getFirst());

    wallet.transfer(msg.value);
    //uint256 tokenAmount = rate.mul(msg.value); //use safemaths
    uint256 tokenAmount = rate * (msg.value);
    tokenTransfer(msg.sender, tokenAmount);
    //tokensSold = tokensSold.sum(tokenAmount);
    tokensSold += tokenAmount;
    q.dequeue();
  }

  function tokenTransfer(address to, uint256 tokenAmount){// check this
      token.transfer(to, tokenAmount);
  }

}
