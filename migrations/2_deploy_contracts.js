const Decentragram = artifacts.require("Decentragram");

module.exports = function(deployer) { //puts smart contracts onto the chain 
  // Code goes here...
  deployer.deploy(Decentragram);
};