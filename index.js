const fs = require('fs'); // Built-in dependency for file streaming.
const solc = require('solc'); // Our Solidity compiler
const Web3 = require('web3'); // Blockchain API

const file_name = process.argv[2]
const blockchain_network = "http://localhost:8545"
const content = fs.readFileSync(file_name, 'utf-8');


// Read the solidity file into a javascript dictionary
const input = {
  language: 'Solidity',
  sources: {},
  settings: {
    outputSelection: {
      '*': {
        '*': ['*']
      }
    }
  }
}; 
input["sources"][file_name] = { content }

// Connect to the local blockchain simulator
const provider = new Web3.providers.HttpProvider(blockchain_network);
const web3 = new Web3(provider);
console.log("Connected")

// Compile the solidity data
const output = JSON.parse(solc.compile(JSON.stringify(input)));
console.log(output)
const { Main } = output.contracts[file_name]
const { abi, evm } = Main
const contract = new web3.eth.Contract(abi);
console.log("Compiled")

const deployAndRunContract = async () => {
    // Get the addresses of Ganache's fake wallet:
    const addresses = await web3.eth.getAccounts();
    
    // Get the current price of gas
    const gasPrice = await web3.eth.getGasPrice();
  
    // Deploy the SolFile contract (its bytecode) 
    // by spending some gas from our first address
    contract.deploy({
      data: evm.bytecode.object,
    })
    .send({
      from: addresses[0],
      gas: 1000000,
      gasPrice,
    })
    .on('confirmation', async (confNumber, receipt) => {
      const { contractAddress } = receipt
      console.log("Deployed at", contractAddress);
  
      // Get the deployed contract instance:
      const contractInstance = new web3.eth.Contract(abi, contractAddress)
  
      // Call the main function and log the result:
      const myName = await contractInstance.methods.main().call();
      console.log("Output:", myName);
    })
    .on('error', (err) => {
      console.log("Failed to deploy:", error) 
    })
  }
  
  deployAndRunContract();
