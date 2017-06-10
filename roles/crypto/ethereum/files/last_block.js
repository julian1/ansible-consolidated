
var Web3 = require('web3');
var web3 = new Web3();

web3.setProvider(new web3.providers.HttpProvider('http://localhost:8545'));

var number = web3.eth.getBlock("latest").number 

console.log( number )

var latest = web3.eth.getBlock("latest")

var time = (new Date( web3.eth.getBlock("latest").timestamp * 1000 ) ).toString()

console.log( time )

