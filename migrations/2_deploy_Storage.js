var storage = artifacts.require("./Storage.sol");

module.exports = function(deployer) {
  deployer.deploy(storage, '1000000000000000000');
};
