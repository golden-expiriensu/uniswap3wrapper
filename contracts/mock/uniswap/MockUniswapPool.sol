// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract MockUniswapPool {
    uint160 internal sqrtPriceX96;

    function slot0()
        external
        view
        returns (
            uint160 sqrtPriceX96_,
            int24 tick_,
            uint16 observationIndex_,
            uint16 observationCardinality_,
            uint16 observationCardinalityNext_,
            uint8 feeProtocol_,
            bool unlocked_
        )
    {
        return (sqrtPriceX96, 0, 0, 0, 0, 0, false);
    }

    function setSqrtPriceX96(uint160 _value) external {
        sqrtPriceX96 = _value;
    }
}
