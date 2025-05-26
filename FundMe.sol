// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

contract FundMe {
    // Get funds from users
    // Withdraw funds
    // Set a minimum funding value in USD

    uint256 public minimumUsd = 5;

    function fund() public payable {
        
        require(msg.value >= minimumUsd, "Didn't send enough ETH"); // 1e18 is 1 * 10 ** 18
    
    }

    // function withdraw() public {}

    function getPrice() public {

        

    }

    function getConversionRate() public {

    }

}