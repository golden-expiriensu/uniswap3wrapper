// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {SqrtPriceX96Math} from "../libraries/SqrtPriceX96Math.sol";

contract MockSqrtX96Price {
    function getAmountOutWithinSingleTick(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint160 _sqrtPriceX96
    ) external pure returns (uint256) {
        return
            SqrtPriceX96Math.getAmountOutWithinSingleTick(
                _tokenIn,
                _tokenOut,
                _amountIn,
                _sqrtPriceX96
            );
    }
}
