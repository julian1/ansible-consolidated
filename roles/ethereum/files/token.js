
var Web3 = require('web3');
var web3 = new Web3();

var fs = require('fs');

web3.setProvider(new web3.providers.HttpProvider('http://localhost:8545'));


////////////
// Need to find out how can record the contract...
// http://pastebin.com/AGDsJL6j
source = fs.readFileSync('./docker/examples/token.solc' ).toString('ascii');
compiled = web3.eth.compile.solidity(source);
contract = web3.eth.contract(compiled.token.info.abiDefinition);
token = contract.at('0xadd1a267057309c917e1ac794050201378e13b0d');


// console.log( token ) 
console.log( compiled ) 


