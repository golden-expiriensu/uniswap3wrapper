// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {PoolGetter} from "./base/PoolGetter.sol";
import {UniswapPriceGetter} from "./components/UniswapPriceGetter.sol";

contract UniswapWrapper is PoolGetter, UniswapPriceGetter {
    constructor(address _uniswapV3Factory) PoolGetter(_uniswapV3Factory) {}
}
