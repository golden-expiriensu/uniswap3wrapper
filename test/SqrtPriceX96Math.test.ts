import { expect } from 'chai'
import { BigNumber } from 'ethers'
import { ethers } from 'hardhat'

import { MockSqrtX96Price, MockSqrtX96Price__factory } from '../typechain'

const format18 = (value: string | BigNumber) => ethers.utils.formatEther(value)
const format6 = (value: string | BigNumber) => ethers.utils.formatUnits(value, 6)

const parse18 = (value: string | number) => ethers.utils.parseEther(value.toString())
const parse6 = (value: string | number) => ethers.utils.parseUnits(value.toString(), 6)

const address00 = ethers.constants.AddressZero
const address01 = address00.substring(0, 41) + '1'

const usdcX96weth = BigNumber.from('2205420398854823255694208494807966')

describe('SqrtPriceX96 Math tests', () => {
  let lib: MockSqrtX96Price

  beforeEach(async () => {
    const [owner] = await ethers.getSigners()

    lib = await new MockSqrtX96Price__factory(owner).deploy()
  })

  it('Should correctly calculate amountOut where USDC < WETH', async () => {
    // 1 USDT = 0.00077 WETH
    const amountOut01 = await lib.getAmountOutWithinSingleTick(address00, address01, parse6(1), usdcX96weth)

    expect(format18(amountOut01)).eq('0.000774860650778562')
  })

  it('Should correctly calculate amountOut where USDC > WETH', async () => {
    // 1 WETH = 1290.55 USDC
    const amountOut10 = await lib.getAmountOutWithinSingleTick(address01, address00, parse18(1), usdcX96weth)

    expect(format6(amountOut10)).eq('1290.554629')
  })
})
