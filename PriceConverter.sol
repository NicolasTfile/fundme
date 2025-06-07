// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    
    function getPrice() internal view returns (uint256) {

        // Address:  Sepolia testnet 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // Address: Zksync testnet 0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xfEefF7c3fB57d18C5C6Cdd71e45D2D0b4F9377bF);
        (,int256 price,,,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // Solidity doesn't work with decimals therefore you get e.g 200000000000
        // = 2000.00000000
        
        return uint256(price * 1e10); // typecast int to uint since msg.value is a uint

    }

    function getConversionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // 1e18 * 1e18 = 1e36 / 1e18 = 1e18
        return ethAmountInUsd;

    }

}