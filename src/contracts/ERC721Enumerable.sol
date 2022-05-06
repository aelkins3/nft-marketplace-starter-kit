// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './ERC721.sol';

contract ERC721Enumerable is ERC721 {

    uint256[] private _allTokens;

        // CHALLENGE! Write out mapping yourself
    // mapping from tokenId to position in _allTokens array
      mapping(uint256 => uint256) private _allTokensIndex;

    // mapping of owner to list of all owner token ids
      mapping(address => uint256[]) private _ownedTokens;

    // mapping from token ID to index of the owner tokens list
      mapping(uint256 => uint256) private _ownedTokensIndex;

    //function tokenByIndex(uint256 _index) external view returns (uint256);

    //function tokenOfOwnerByIndex(address _owner, uint256 _index) external view returns (uint256);

    function _mint(address to, uint256 tokenId) internal override(ERC721) {
      super._mint(to, tokenId);
      // 2 things! A. add tokens to the owner
      // B. all tokens to our totalsupply - to allTokens
      _addTokensToAllTokenEnumeration(tokenId);
      _addTokensToOwnerEnumeration(to, tokenId);
    }

    // add tokens to the _allTokens array and set the position of the tokens indexes
    function _addTokensToAllTokenEnumeration(uint256 tokenId) private {
      _allTokensIndex[tokenId] = _allTokens.length;
      _allTokens.push(tokenId);
    }

    function _addTokensToOwnerEnumeration(address to, uint256 tokenId) private {
      // EXERCISE - CHALLENGE - DO THESE THREE THINGS:
      // 1. add address and token id to the _ownedTokens
      _ownedTokens[to].push(tokenId);
      // 2. ownedTokensIndex tokenId set to the address of the ownedTokens position
      _ownedTokensIndex[tokenId] = _ownedTokens[to].length;
      // 3. we want to execute the function with minting
      _addTokensToAllTokenEnumeration(tokenId);
    }

    // two functions - one that returns tokenByIndex
    // another one that returns tokenOfOwnerByIndex

    function tokenByIndex() public view returns(uint256 index) {
      // make sure that the index is not out of bounds
      require(index < totalSupply(), 'global index is out of bounds!');
      return _allTokens[index];
    }

    function tokenOfOwnerByIndex(address owner, uint index) public view returns(uint256) {
      require(index < balanceOf(owner), 'global index is out of bounds!');
      return _ownedTokens[owner][index];
    }

    // return the total supply of the _allTokens array
    function totalSupply() public view returns(uint256) {
      return _allTokens.length;
    }
}