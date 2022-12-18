// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {ImmutableState} from "./base/ImmutableState.sol";
import {UniswapPriceGetter} from "./components/UniswapPriceGetter.sol";

contract UniswapWrapper is ImmutableState, UniswapPriceGetter {
    constructor(address _uniswapV3Factory) ImmutableState (_uniswapV3Factory) {}
}
