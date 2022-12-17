// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MockUniswapRouter {
    struct ExactInputSingleParams {
        address tokenIn;
        address tokenOut;
        uint24 fee;
        address recipient;
        uint256 deadline;
        uint256 amountIn;
        uint256 amountOutMinimum;
        uint160 sqrtPriceLimitX96;
    }

    address public immutable factory;

    mapping(address => mapping(address => mapping(uint24 => uint160))) internal tokens2price;

    constructor(address _factory) {
        factory = _factory;
    }

    function setPool(
        address _token0,
        address _token1,
        uint24 _poolFee,
        uint160 _priceSqrtX96_0_1,
        uint160 _priceSqrtX96_1_0
    ) external {
        tokens2price[_token0][_token1][_poolFee] = _priceSqrtX96_0_1;
        tokens2price[_token1][_token0][_poolFee] = _priceSqrtX96_1_0;
    }

    function exactInputSingle(ExactInputSingleParams calldata _params)
        external
        returns (uint256 amountOut_)
    {
        IERC20(_params.tokenIn).transferFrom(msg.sender, address(this), _params.amountIn);

        (address token0, address token1) = sortTokens(_params.tokenIn, _params.tokenOut);

        uint160 sqrtPriceX96 = tokens2price[token0][token1][_params.fee];

        // Theoretical formula:
        // P = (sqrtPriceX96 / 2^96)^2
        // 1. token0 == tokenIn: amountIn * P
        // 2. token0 != tokenIn: amountIn * (1 / P)
        // Formulas below do the same thing but with uints and overflow guards (support up to 18e18 which is enough for mock)
        amountOut_ = token0 == _params.tokenIn // prettier-ignore
            ? (((_params.amountIn * sqrtPriceX96) / 2**96) * sqrtPriceX96) / 2**96 // prettier-ignore
            : ((_params.amountIn * 2**192) / sqrtPriceX96) / sqrtPriceX96;

        IERC20(_params.tokenOut).transfer(_params.recipient, amountOut_);
    }

    function sortTokens(address _tokenA, address _tokenB) private pure returns (address, address) {
        return _tokenA < _tokenB ? (_tokenA, _tokenB) : (_tokenB, _tokenA);
    }
}
