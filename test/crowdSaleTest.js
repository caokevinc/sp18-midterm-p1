'use strict';

/* Add the dependencies you're testing */
const Crowdsale = artifacts.require("./Crowdsale.sol");
const Crowdsale = artifacts.require("./Token.sol");

// YOUR CODE HERE

contract('testTemplate', function(accounts) {
	/* Define your constant variables and instantiate constantly changing
	 * ones
	 */
	const args = {};
	let x, y, z;
	// YOUR CODE HERE

	/* Do something before every `describe` method */
	beforeEach(async function() {
		// YOUR CODE HERE
    token = await Token.new(10);
    tempWallet = await Queue.new();
		cs = await Crowdsale.new(10000, token, tempWallet.address);
	});

	/* Group test cases together
	 * Make sure to provide descriptive strings for method arguements and
	 * assert statements
	 */
	describe('Test Token', function() {
		it("Token should ", async function() {
			// YOUR CODE HERE
      async function() {
				let cleanBalance = await cs.getBalance.call();
				/* Why do you think `.valueOf()` is necessary? */
				assert.equal(cleanBalance.valueOf(), args._bigAmount,
					"value set correctly");
				/* Why do you think `.call(...)` is used? */
				let target = await notPoisoned.getTarget.call();
				assert.equal(target, good.address,
					"target locked correctly");
		});
		});
		// YOUR CODE HERE
	});

	describe('Your string here', function() {
		// YOUR CODE HERE
	});
});
