import { HardhatRuntimeEnvironment } from 'hardhat/types'

import { DELAY_BEFORE_VERIFY, HARDHAT_CHAIN_ID } from './config'

export const verify = async (
  hre: HardhatRuntimeEnvironment,
  contract: string,
  // eslint-disable-next-line
  constructorArguments: any[],
): Promise<void> => {
  if ((await hre.getChainId()) === HARDHAT_CHAIN_ID) return

  await new Promise((r) => setTimeout(r, DELAY_BEFORE_VERIFY))

  await hre.run('verify:verify', {
    address: (await hre.ethers.getContract(contract)).address,
    constructorArguments,
  })
}
