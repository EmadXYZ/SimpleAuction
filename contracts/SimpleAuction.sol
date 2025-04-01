// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

/**
 * @title SimpleAuction
 * @dev A simple open auction contract where the highest bidder wins.
 */
contract SimpleAuction {
    address payable public beneficiary;
    uint256 public auctionEndTime;

    address public highestBidder;
    uint256 public highestBid;

    mapping(address => uint256) pendingReturns;

    bool ended;

    event HighestBidIncreased(address bidder, uint256 amount);
    event AuctionEnded(address winner, uint256 amount);

    error AuctionAlreadyEnded();
    error BidNotHighEnough(uint256 highestBid);
    error AuctionNotYetEnded();
    error AuctionEndAlreadyCalled();

    /**
     * @dev Constructor initializes the auction with a bidding time and a beneficiary address.
     * @param biddingTime Duration of the auction in seconds.
     * @param beneficiaryAddress Address that will receive the highest bid at the end.
     */
    constructor(uint256 biddingTime, address payable beneficiaryAddress) {
        beneficiary = beneficiaryAddress;
        auctionEndTime = block.timestamp + biddingTime;
    }

    /**
     * @dev Allows users to place bids. If a new highest bid is placed, the previous highest bidder is refunded.
     */
    function bid() external payable {
        if (block.timestamp > auctionEndTime) revert AuctionAlreadyEnded();
        if (msg.value <= highestBid) revert BidNotHighEnough(highestBid);

        if (highestBid != 0) {
            pendingReturns[highestBidder] += highestBid;
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit HighestBidIncreased(msg.sender, msg.value);
    }

    /**
     * @dev Allows users to withdraw their pending returns if they have been outbid.
     */
    function withdraw() external returns (bool) {
        uint256 amount = pendingReturns[msg.sender];
        if (amount > 0) {
            pendingReturns[msg.sender] = 0;

            (bool success, ) = payable(msg.sender).call{value: amount}("");
            if (!success) {
                pendingReturns[msg.sender] = amount;
                return false;
            }
        }
        return true;
    }

    /**
     * @dev Ends the auction and transfers the highest bid amount to the beneficiary.
     */
    function auctionEnd() external {
        if (block.timestamp < auctionEndTime) revert AuctionNotYetEnded();
        if (ended) revert AuctionEndAlreadyCalled();

        ended = true;
        emit AuctionEnded(highestBidder, highestBid);

        (bool success, ) = beneficiary.call{value: highestBid}("");
        require(success, "Transfer failed.");
    }

    /**
     * @dev Prevents accidental direct ETH transfers to the contract.
     */
    receive() external payable {
        revert("Direct ETH transfer not allowed.");
    }

    /**
     * @dev Fallback function to handle unexpected function calls.
     */
    fallback() external payable {
        revert("Function does not exist.");
    }
}
