// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IUniswapV3PoolState} from "@uniswap/v3-core/contracts/interfaces/pool/IUniswapV3PoolState.sol";

import {PoolGetter} from "../base/PoolGetter.sol";
import {SqrtPriceX96Math} from "../libraries/SqrtPriceX96Math.sol";

error PoolDoesNotExist();

abstract contract UniswapPriceGetter is PoolGetter {
    /// @param _tokenIn Token to spend
    /// @param _tokenOut Token to receive
    /// @param _amountIn Amount of _tokenIn to spend in swap
    /// @param _fee Pool fee (500, 3000, 10000)
    function _getAmountOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint24 _fee
    ) internal view returns (uint256) {
        address pool = _getPool(_tokenIn, _tokenOut, _fee);

        return _getAmountOut(_tokenIn, _tokenOut, _amountIn, pool);
    }

    /// @param _tokenIn Token to spend
    /// @param _tokenOut Token to receive
    /// @param _amountIn Amount of _tokenIn to spend in swap
    /// @param _pool Address of the pool to use
    function _getAmountOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        address _pool
    ) internal view returns (uint256) {
        (uint160 sqrtPriceX96, , , , , , ) = IUniswapV3PoolState(_pool).slot0();

        return
            SqrtPriceX96Math.getAmountOutWithinSingleTick(
                _tokenIn,
                _tokenOut,
                _amountIn,
                sqrtPriceX96
            );
    }
}
