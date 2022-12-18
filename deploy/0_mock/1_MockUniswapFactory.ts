import { DeployFunction } from 'hardhat-deploy/types'
import { HardhatRuntimeEnvironment } from 'hardhat/types'

import { verify } from '../helpers'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments

  const { deployer } = await getNamedAccounts()
  const args: any[] = []

  await deploy('MockUniswapFactory', {
    from: deployer,
    args,
    log: true,
  })

  await verify(hre, 'MockUniswapFactory', args)
}

export default func
func.tags = ['mock', 'MockUniswapFactory']
