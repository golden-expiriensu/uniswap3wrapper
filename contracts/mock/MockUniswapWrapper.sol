// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {UniswapWrapper} from "../UniswapWrapper.sol";

contract MockUniswapWrapper is UniswapWrapper {
    constructor(address _uniswapFactory) UniswapWrapper(_uniswapFactory) {}

    function getAmountOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        uint24 _fee
    ) external view returns (uint256) {
        return _getAmountOut(
            _tokenIn,
            _tokenOut,
            _amountIn,
            _fee
        );
    }

    function getAmountOut(
        address _tokenIn,
        address _tokenOut,
        uint256 _amountIn,
        address _pool
    ) external view returns (uint256) {
        return _getAmountOut(
            _tokenIn,
            _tokenOut,
            _amountIn,
            _pool
        );
    }
}
