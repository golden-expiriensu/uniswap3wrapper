import { DeployFunction } from 'hardhat-deploy/types'
import { HardhatRuntimeEnvironment } from 'hardhat/types'

import { DEPLOY_ARGS } from './config'
import { verify } from './helpers'

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
  const { deployments, getNamedAccounts } = hre
  const { deploy } = deployments

  const { deployer } = await getNamedAccounts()
  const args = [DEPLOY_ARGS.CONTRACT.VALUE, DEPLOY_ARGS.CONTRACT.IMMUTABLE_VALUE]

  await deploy('Contract', {
    from: deployer,
    args,
    log: true,
  })

  await verify(hre, 'Contract', args)
}

export default func
func.tags = ['mainnet', 'Contract']
func.id = 'Contract'
