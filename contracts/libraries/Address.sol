// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

library Address {
    function sort(address _a, address _b) internal pure returns (address, address) {
        return _a < _b ? (_a, _b) : (_b, _a);
    }
}
