import './tasks'
import '@nomiclabs/hardhat-ethers'
import '@nomiclabs/hardhat-etherscan'
import '@nomiclabs/hardhat-waffle'
import '@typechain/hardhat'
import 'hardhat-contract-sizer'
import 'hardhat-deploy'
import 'hardhat-gas-reporter'
import 'solidity-coverage'

import * as dotenv from 'dotenv'
import { HardhatUserConfig } from 'hardhat/types'

dotenv.config()

if (!process.env.DEPLOYER_PRIVATE_KEY) throw new Error("Specify 'process.env.DEPLOYER_PRIVATE_KEY' in .env file")
if (!process.env.OWNER_PRIVATE_KEY) throw new Error("Specify 'process.env.OWNER_PRIVATE_KEY' in .env file")
if (!process.env.SIGNER_PRIVATE_KEY) throw new Error("Specify 'process.env.SIGNER_PRIVATE_KEY' in .env file")

const config: HardhatUserConfig = {
  solidity: '0.8.4',
  namedAccounts: {
    deployer: {
      hardhat: 0,
      sepolia: 'privatekey://' + process.env.DEPLOYER_PRIVATE_KEY,
    },
    owner: {
      hardhat: 1,
      sepolia: 'privatekey://' + process.env.OWNER_PRIVATE_KEY,
    },
    signer: {
      hardhat: 2,
      sepolia: 'privatekey://' + process.env.SIGNER_PRIVATE_KEY,
    },
  },
  networks: {
    sepolia: {
      url: process.env.SEPOLIA_URL ?? '',
      accounts: [process.env.DEPLOYER_PRIVATE_KEY, process.env.OWNER_PRIVATE_KEY, process.env.SIGNER_PRIVATE_KEY],
    },
  },
  gasReporter: {
    enabled: !!process.env.REPORT_GAS,
    currency: 'USD',
  },
  etherscan: {
    apiKey: {
      sepolia: process.env.ETHERSCAN_API_KEY ?? '',
    },
  },
}

export default config
