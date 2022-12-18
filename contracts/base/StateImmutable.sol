// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {IUniswapV3Factory} from "@uniswap/v3-core/contracts/interfaces/IUniswapV3Factory.sol";

error PoolDoesNotExist();

abstract contract StateImmutable {
    IUniswapV3Factory internal immutable uniswapV3Factory;

    constructor(address _uniswapV3Factory) {
        uniswapV3Factory = IUniswapV3Factory(_uniswapV3Factory);
    }
}
