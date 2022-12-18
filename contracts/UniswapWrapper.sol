// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IUniswapV3Factory} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";
import {IUniswapV3PoolState} from "@uniswap/v3-core/contracts/interfaces/pool/IUniswapV3PoolState.sol";

import {SqrtPriceX96Math} from "./libraries/SqrtPriceX96Math.sol";
import {Address} from "./libraries/Address.sol";

error PoolDoesNotExist();

contract UniswapWrapper {
    IUniswapV3Factory internal immutable uniswapV3Factory;

    constructor(address _uniswapV3Factory) {
        uniswapV3Factory = IUniswapV3Factory(_uniswapV3Factory);
    }

    /// @param _tokenIn Token to spend
    /// @param _tokenOut Token to receive
    /// @param _amountIn Amount of _tokenIn to spend in swap
    /// @param _fee Pool fee (300, 5000, 10000)
    function getAmountOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint24 _fee
    ) internal view returns (uint256) {
        address pool = uniswapV3Factory.getPool(_tokenIn, _tokenOut, _fee);

        return getAmountOut(_tokenIn, _tokenOut, _amountIn, pool);
    }

    /// @param _tokenIn Token to spend
    /// @param _tokenOut Token to receive
    /// @param _amountIn Amount of _tokenIn to spend in swap
    /// @param _pool Address of the pool to use
    function getAmountOut(
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
