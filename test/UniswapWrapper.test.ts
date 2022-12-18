import { BigNumber } from 'ethers'
import { deployments, ethers } from 'hardhat'

import {
  MockToken,
  MockToken__factory,
  MockUniswapFactory,
  MockUniswapPool,
  MockUniswapRouter,
  MockUniswapWrapper,
} from '../typechain'
import { format18, format6, parse18, parse6 } from './helpers'

const uniswapMockData = {
  // For 1 USDC you will get 0.000774842896 WETH
  // This calculated from (priceSqrtX96 / 2^96)^2 and applying decimals
  usdc2wethSqrtX96: BigNumber.from('2205420398854823255694208494807966'),
  weth2usdcSqrtX96: BigNumber.from('2846215505509108635263996'),
  usdc2wethFee: 500,
}

describe('UniswapWrapper tests', () => {
  let uniswapWrapper: MockUniswapWrapper

  let usdc: MockToken, weth: MockToken

  beforeEach(async () => {
    const [deployer] = await ethers.getSigners()

    const tokenFactory = new MockToken__factory(deployer)

    usdc = await tokenFactory.deploy('USD Coin', 'USDC', 6)
    weth = await tokenFactory.deploy('Wrapped Ether', 'WETH', 18)

    await deployments.fixture(['mock', 'mainnet'])

    const uniFactory = await ethers.getContract<MockUniswapFactory>('MockUniswapFactory')
    const uniRouter = await ethers.getContract<MockUniswapRouter>('MockUniswapRouter')

    const usdc2wethPool = await ethers.getContract<MockUniswapPool>('MockUniswapPool')

    await uniFactory.setPool(usdc.address, weth.address, uniswapMockData.usdc2wethFee, usdc2wethPool.address)

    await uniRouter.setPool(
      usdc.address,
      weth.address,
      uniswapMockData.usdc2wethFee,
      uniswapMockData.usdc2wethSqrtX96,
      uniswapMockData.weth2usdcSqrtX96,
    )

    await usdc2wethPool.setSqrtPriceX96(
      usdc.address < weth.address ? uniswapMockData.usdc2wethSqrtX96 : uniswapMockData.weth2usdcSqrtX96,
    )

    uniswapWrapper = await ethers.getContract('MockUniswapWrapper')
  })

  it('TODO', async () => {
    console.log(
      format18(
        await uniswapWrapper['getAmountOut(address,address,uint256,uint24)'](
          usdc.address,
          weth.address,
          parse6(1000),
          uniswapMockData.usdc2wethFee,
        ),
      ),
    )

    console.log(
      format6(
        await uniswapWrapper['getAmountOut(address,address,uint256,uint24)'](
          weth.address,
          usdc.address,
          parse18(1),
          uniswapMockData.usdc2wethFee,
        ),
      ),
    )
  })
})
