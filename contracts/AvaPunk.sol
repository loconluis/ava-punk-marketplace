// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MyToken is ERC721, ERC721Enumerable {
    uint256 private counter;
    uint public maxSupply;
    mapping(uint256 => bool) private tokenMinted;

    constructor(uint256 _maxSupply) ERC721("AvaPunks", "AVAPKS") {
        maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 current = counter;
        require(current < maxSupply, "Not AvaPunk Left :(");
        _safeMint(msg.sender, current);
        tokenMinted[current] = true;
        counter = counter + 1;
    }

    // Override require
    function tokenURI(uint256 tokenId) 
        public
        view
        override
        returns (string memory)
    {
        require(tokenMinted[tokenId] == true, "ERC721 Metadata for not existing query");
        bytes memory dataURI = abi.encodePacked(
                '{ "name": "AvaPunks #',
                tokenId,
                '",  "description": "Ava Punks is a randominze of the library Avaatar", "image": "',
                "//TODO calculate Image URL", 
                '"}'
            );
        return string(abi.encodePacked(
                "data:application/json;base64,",
                Base64.encode(dataURI)
            ));
    }

    function _update(address to, uint256 tokenId, address auth)
        internal
        override(ERC721, ERC721Enumerable)
        returns (address)
    {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._increaseBalance(account, value);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}