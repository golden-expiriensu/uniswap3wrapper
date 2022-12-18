// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {StateImmutable} from "./base/StateImmutable.sol";
import {UniswapPriceGetter} from "./components/UniswapPriceGetter.sol";

contract UniswapWrapper is StateImmutable, UniswapPriceGetter {
    constructor(address _uniswapV3Factory) StateImmutable (_uniswapV3Factory) {}
}
