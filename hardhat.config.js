require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

const pritave_key = process.env.key;
const infura_id = process.env.infura; 



/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks:{  
    sepolia:{
      url: `https://sepolia.infura.io/v3/${infura_id}`,
      accounts: [pritave_key],
    },
  }, 
};
