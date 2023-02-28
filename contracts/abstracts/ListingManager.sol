// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import './Controlable.sol';

import '@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol';

abstract contract ListingManager is Controlable, IERC721Receiver {
  struct Listing {
    address tokenContract;
    uint tokenId;
    uint salePrice;
    address seller;
    address buyer;
    uint listingTimestamp;
    uint buyTimestamp;
  }

  uint32 public constant BASE_TRANSACTION_FEE = 100_000;
  uint256 private _listingId = 0;
  mapping(uint256 => Listing) internal _listings;

  event ListingCreated();
  event Sale();

  function _createListing(address tokenContract, uint256 tokenId, uint256 salePrice) internal returns (uint256 listingId) {
    require(salePrice > 0, 'Sell price must be above zero');

    IERC721(tokenContract).safeTransferFrom(msg.sender, address(this), tokenId);

    Listing memory listing = Listing(tokenContract, tokenId, salePrice, msg.sender, address(0), block.timestamp, 0);
    _listings[_listingId] = listing;
    _listingId++;

    emit ListingCreated();
  }

  function _buyListing(uint256 listingId) internal returns (bool success) {
    // To-Do: Receive token with transferFrom or safeTransferFrom
    // Calculate fees
    // Increment fee counter
    // Calculate rest of amount to send to seller
    // To-Do: Send sale amount minus fees to seller
  }
}
