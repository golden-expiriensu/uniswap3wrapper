// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {ISwapRouter} from "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";

import {PoolGetter} from "../base/PoolGetter.sol";

/// @dev This contract utilizes UniswapV3 periphery router
/// @dev therefore it has gas overflow because of call to external contract
/// @dev Useful if final contract has not enough space to accommodate UniswapSwapInternal
abstract contract UniswapSwapExternal is PoolGetter {
    ISwapRouter internal immutable uniswapV3Router;

    constructor(address _uniswapV3Router) {
        uniswapV3Router = ISwapRouter(_uniswapV3Router);
    }

    /// @dev Has deadline block.timestamp, no limit on max/min sqrt price at last tick and no min amount to receive guard
    /// @param _tokenIn Token to spend
    /// @param _tokenOut Token to receive
    /// @param _fee Pool fee (500, 3000, 10000)
    /// @param _recipient Address of _tokenOut recipient
    /// @param _amountIn Amount to spend
    /// @return amountOut_ Amount, received after a swap by _receipient
    function swap(
        address _tokenIn,
        address _tokenOut,
        uint24 _fee,
        address _recipient,
        uint256 _amountIn
    ) internal returns (uint256 amountOut_) {
        return
            uniswapV3Router.exactInputSingle(
                ISwapRouter.ExactInputSingleParams({
                    tokenIn: _tokenIn,
                    tokenOut: _tokenOut,
                    fee: _fee,
                    recipient: _recipient,
                    deadline: block.timestamp,
                    amountIn: _amountIn,
                    amountOutMinimum: 0,
                    sqrtPriceLimitX96: 0
                })
            );
    }
}
