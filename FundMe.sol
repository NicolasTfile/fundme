// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

// import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded) public addressToAmountFunded;

    function fund() public payable {
        
        require(msg.value.getConversionRate() >= minimumUsd, "Didn't send enough ETH"); // 1e18 is 1 * 10 ** 18

        funders.push(msg.sender);

        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    
    }

    // function withdraw() public {}

}