// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

contract FundMe {
    // Get funds from users
    // Withdraw funds
    // Set a minimum funding value in USD

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        
        require(getConversionRate(msg.value) >= minimumUsd, "Didn't send enough ETH"); // 1e18 is 1 * 10 ** 18

        funders.push(msg.sender);

        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    
    }

    // function withdraw() public {}

    function getPrice() public view returns (uint256) {

        // Address: 0x694AA1769357215DE4FAC081bf1f309aDC325306
        // ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);

        (,int256 price,,,) = priceFeed.latestRoundData();
        // Price of ETH in terms of USD
        // Solidity doesn't work with decimals therefore you get e.g 200000000000
        // = 2000.00000000
        
        return uint256(price * 1e10); // typecast int to uint since msg.value is a uint

    }

    function getConversionRate(uint256 ethAmount) public view returns (uint256) {

        uint256 ethPrice = getPrice();

        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18; // 1e18 * 1e18 = 1e36 / 1e18 = 1e18

        return ethAmountInUsd;

    }

}