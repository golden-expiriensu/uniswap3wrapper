import { DeployFunction } from 'hardhat-deploy/types'
import { HardhatRuntimeEnvironment } from 'hardhat/types'

import { verify } from '../helpers'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments

  const { deployer } = await getNamedAccounts()
  const args = [(await hre.ethers.getContract("MockUniswapFactory")).address]

  await deploy('MockUniswapRouter', {
    from: deployer,
    args,
    log: true,
  })

  await verify(hre, 'MockUniswapRouter', args)
}

export default func
func.tags = ['mock', 'MockUniswapRouter']
