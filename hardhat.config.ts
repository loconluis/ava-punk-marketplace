import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config";

const config: HardhatUserConfig = {
  solidity: "0.8.27",
  networks: {
    sepolia: {
      url: `${process.env.SEPOLIA_TESTNET_URI}${process.env.INFRA_API_KEY}`,
      accounts: [`0x${process.env.DEPLOYER_SIGNER_PRIVATE_KEY}`],
    },
    holesky: {
      url: `${process.env.HOLESKY_TESTNET_URI}${process.env.INFRA_API_KEY}`,
      accounts: [`0x${process.env.DEPLOYER_SIGNER_PRIVATE_KEY}`],
    },
  },
};

export default config;
