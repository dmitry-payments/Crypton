Crypton.unit.test.js

const { expect } = require('chai');
const { BN, expectRevert} = require('@openzeppelin/test-helpers');
const { web3 } = require('@openzeppelin/test-helpers/src/setup');

const Crypton = artifacts.require('Crypton');

contract('Crypton', function (accounts) {

    const [owner, account1] = accounts;

    describe("Create contract", async function() {
        it("Deploy", async function() {
            const crypton = await Crypton.new({from: owner});
        });
    });

    describe("Trying to deposit", async function () {
        it("Positive", async function() {
            const crypton = await Crypton.new({from: owner});

            await crypton.deposit({from: account1, value: 10000});
            expect(await crypton.getAmount(account1)).to.bignumber.equal("10000");
        });

        it("Negative", async function() {
            const crypton = await Crypton.new({from: owner});

            await expectRevert(crypton.deposit({from: account1}), "Incorrect value");
        });
    });

    describe("Trying to withdraw", async function () {
        it("Positive", async function() {
            const crypton = await Crypton.new({from: owner});

            await crypton.deposit({from: account1, value: 10000});

            await crypton.withdraw(account1, 10000,{from: owner});
        });

        it("Negative", async function() {
            const crypton = await Crypton.new({from: owner});

            await crypton.deposit({from: account1, value: 10000});
            
            await expectRevert(crypton.withdraw(account1, 100000,{from: owner}), "Insufficient funds");

            await expectRevert(crypton.withdraw(account1, 10000,{from: account1}), "Ownable: caller is not the owner");
        });
    });
});