// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IUniswapV3Factory} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import {UniswapWrapper} from "../UniswapWrapper.sol";

contract MockUniswapWrapper is UniswapWrapper {
    constructor(address _uniswapFactory) UniswapWrapper(_uniswapFactory) {}

    function getAmountOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint24 _fee
    ) external view returns (uint256) {
        return _getAmountOut(_tokenIn, _tokenOut, _amountIn, _fee);
    }

    function getAmountOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        address _pool
    ) external view returns (uint256) {
        return _getAmountOut(_tokenIn, _tokenOut, _amountIn, _pool);
    }

    function _getPool(
        address _tokenA,
        address _tokenB,
        uint24 _poolFee
    ) internal view override returns (address) {
        return IUniswapV3Factory(uniswapV3Factory).getPool(_tokenA, _tokenB, _poolFee);
    }
}
