// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {FullMath} from "@uniswap/v3-core/contracts/libraries/FullMath.sol";
import {Address} from "./Address.sol";

error AmountInIsTooLarge();

library SqrtPriceX96Math {
    function getAmountOutWithinSingleTick(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint160 _sqrtPriceX96
    ) internal pure returns (uint256 amountOut_) {
        // We assume, that max total supply of an adequate token < 5.19e31 = 5,192,296,858,534,827e18
        if (_amountIn > 2**112) revert AmountInIsTooLarge();

        (address token0, ) = Address.sort(_tokenIn, _tokenOut);

        // prettier-ignore
        if (_tokenIn == token0) {
            uint256 amountMulPrice = FullMath.mulDiv(_amountIn, _sqrtPriceX96, 2**16);
            return FullMath.mulDiv(amountMulPrice, _sqrtPriceX96, 2**176);
        } else {
            uint256 amountMul192 = FullMath.mulDiv(_amountIn, 2**192, _sqrtPriceX96);
            return amountMul192 / _sqrtPriceX96;
        }
    }
}
