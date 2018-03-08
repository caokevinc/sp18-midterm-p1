/**
 * @title Queue
 * @dev Data structure contract used in `Crowdsale.sol`
 * Allows buyers to line up on a first-in-first-out basis
 * See this example: http://interactivepython.org/courselib/static/pythonds/BasicDS/ImplementingaQueueinPython.html
 */

contract Queue {
	/* State variables */
	uint8 size = 5;
	address[5] q_to_address;
	mapping (address => uint) address_to_time;
	uint8 start_q;
	uint8 end_q;
	uint8 currsize;
	// YOUR CODE HERE

	/* Add events */
	event TimedOut(address removed_from_queue);

	/* Add constructor */
	function Queue() public {
	    start_q = 0;
	    end_q = 0;
	    currsize = 0;
	}

	/* Returns the number of people waiting in line */
	function qsize() constant returns(uint8) {
		return currsize;
	}

	/* Returns whether the queue is empty or not */
	function empty() constant returns(bool) {
		if (currsize == 0) {
		    return true;
		} else {
		    return false;
		}
	}

	/* Returns the address of the person in the front of the queue */
	function getFirst() constant returns(address) {
		return q_to_address[start_q];
	}

	/* Allows `msg.sender` to check their position in the queue */
	function checkPlace(address a) constant returns(uint8) {
		for (uint8 counter = 0; counter < currsize; counter++) {
		    if (q_to_address[(start_q + counter) % size] == a) {
		        return counter + 1;
		    }
		}
	}

	/* Allows anyone to expel the first person in line if their time
	 * limit is up
	 */
	function checkTime() {
		while (now - address_to_time[q_to_address[(start_q) % size]] >= 1 minutes ) {
		    if (currsize == 0) {
		        return;
		    }
		    TimedOut(q_to_address[(start_q) % size]);
		    dequeue();
		}
	}

	/* Removes the first person in line; either when their time is up or when
	 * they are done with their purchase
	 */
	function dequeue() {
	    if (currsize > 0) {
	        delete address_to_time[q_to_address[start_q]];
	        q_to_address[start_q] = address(0);
	        start_q = (start_q + 1) % size;
	        currsize -= 1;
	    }

	}

	/* Places `addr` in the first empty position in the queue */
	function enqueue(address addr) {
		if (currsize < 5) {
		    address_to_time[addr] = now;
		    q_to_address[end_q] = msg.sender;
		    end_q = (end_q + 1) % 5;
		    currsize += 1;
		}
	}
}
