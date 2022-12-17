// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.4;

contract MockUniswapFactory {
    mapping(address => mapping(address => mapping(uint24 => address))) private pools;

    function getPool(
        address _tokenA,
        address _tokenB,
        uint24 _poolFee
    ) external view returns (address) {
        (address token0, address token1) = sortTokens(_tokenA, _tokenB);

        return pools[token0][token1][_poolFee];
    }

    function setPool(
        address _tokenA,
        address _tokenB,
        uint24 _poolFee,
        address _pool
    ) external {
        (address token0, address token1) = sortTokens(_tokenA, _tokenB);

        pools[token0][token1][_poolFee] = _pool;
    }

    function sortTokens(address _tokenA, address _tokenB) private pure returns (address, address) {
        return _tokenA < _tokenB ? (_tokenA, _tokenB) : (_tokenB, _tokenA);
    }
}
