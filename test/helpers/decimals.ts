import { BigNumber, utils } from 'ethers'

export const format18 = (value: string | BigNumber) => utils.formatEther(value)
export const format6 = (value: string | BigNumber) => utils.formatUnits(value, 6)

export const parse18 = (value: string | number) => utils.parseEther(value.toString())
export const parse6 = (value: string | number) => utils.parseUnits(value.toString(), 6)
