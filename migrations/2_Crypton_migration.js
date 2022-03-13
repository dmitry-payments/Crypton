const Crypton = artifacts.require("Crypton");

module.exports = function (deployer) {
  deployer.deploy(Crypton);
};
