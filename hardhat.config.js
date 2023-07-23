require("@nomicfoundation/hardhat-toolbox");

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks:{  
    sepolia:{
      url: `https://sepolia.infura.io/v3/4e7b5be588264b51909c59ab417f3d09`,
      accounts: [
        "1c04dc5ef858bad4f49b7bf6683de4d3b43c5ca75eb8b28a7aa6dc266c0b50c0",
        
      ],
    },
  }, 
};
