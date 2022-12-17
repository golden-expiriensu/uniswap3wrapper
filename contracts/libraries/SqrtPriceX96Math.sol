// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

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
            unchecked {
                return (((_amountIn * (_sqrtPriceX96 / 2**16)) / 2**80) * _sqrtPriceX96) / 2**96;
            }
        } else {
            unchecked {
                return (((_amountIn * 2**144) / _sqrtPriceX96) * 2**48) / _sqrtPriceX96;
            }
        }
    }
}
