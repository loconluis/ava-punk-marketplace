// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import "./AvaPunkDNA.sol";

contract AvaPunk is ERC721, ERC721Enumerable, AvaPunkDNA {
    uint256 private counter;
    uint256 public maxSupply;
    mapping(uint256 => bool) private tokenMinted;
    mapping(uint256 => uint256) public tokenDNA;

    constructor(uint256 _maxSupply) ERC721("AvaPunks", "AVAPKS") {
        maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 current = counter;
        require(current < maxSupply, "Not AvaPunk Left :(");

        tokenDNA[current] = deterministicPseudRandomDNA(current, msg.sender);
        _safeMint(msg.sender, current);
        tokenMinted[current] = true;
        counter = counter + 1;
    }

    function _baseURI() 
			internal
			pure
			override
			returns(string memory)
    {
			return "https://avataaars.io/";
    }


    function _paramsURI(uint256 _dna) internal view returns(string memory) {
        string memory params;
        params = string(abi.encodePacked(
            "accessoriesType=",
            getAccesoriesTypes(uint8(_dna)),
            "&clotheColor=",
            getClotheColor(uint8(_dna)),
            "&clotheType=",
            getClotheType(_dna),
            "&eyeType=",
            getEyeType(_dna),
            "&eyebrowType=",
            getEyeBrowType(_dna),
            "&facialHairColor=",
            getFacialHairColor(_dna),
            "&facialHairType=",
            getFacialHairType(_dna),
            "&hairColor=",
            getHairColor(_dna),
            "&hatColor=",
            getHatColor(_dna),
            "&graphicType=",
            getGraphicType(_dna),
            "&mouthType=",
            getMouthType(_dna),
            "&skinColor=",
            getSkinColor(_dna)
        ));
        return params;
    }

    function imageByDNA(uint256 _dna) public view returns (string memory) {
        string memory baseURI = _baseURI();
        string memory paramsURI = _paramsURI(_dna);

        return string(abi.encodePacked(baseURI,"?", paramsURI));
    }

    // Override require
    function tokenURI(uint256 tokenId) 
        public
        view
        override
        returns (string memory)
    {
        require(tokenMinted[tokenId] == true, "ERC721 Metadata for not existing query");
        
        uint256 dna = tokenDNA[tokenId];
        string memory image = imageByDNA(dna);

        bytes memory dataURI = abi.encodePacked(
                '{ "name": "AvaPunks #',
                Strings.toString(tokenId),
                '",  "description": "Ava Punks is a randominze of the library Avaatar", "image": "',
                image,
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