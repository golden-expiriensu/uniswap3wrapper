// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {Address} from "../libraries/Address.sol";

abstract contract PoolGetter {
    bytes32 internal constant POOL_INIT_CODE_HASH =
        0xa598dd2fba360510c5a8f02f44423a4468e902df5857dbce3ca162a43a3a31ff;

    address internal immutable uniswapV3Factory;

    constructor(address _uniswapV3Factory) {
        uniswapV3Factory = _uniswapV3Factory;
    }

    function _getPool(
        address _tokenA,
        address _tokenB,
        uint24 _poolFee
    ) internal view virtual returns (address) {
        return _computeAddress(uniswapV3Factory, _tokenA, _tokenB, _poolFee);
    }

    function _computeAddress(
        address _factory,
        address _tokenA,
        address _tokenB,
        uint24 _poolFee
    ) private pure returns (address pool) {
        (address token0, address token1) = Address.sort(_tokenA, _tokenB);
        pool = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            hex"ff",
                            _factory,
                            keccak256(abi.encode(token0, token1, _poolFee)),
                            POOL_INIT_CODE_HASH
                        )
                    )
                )
            )
        );
    }
}
