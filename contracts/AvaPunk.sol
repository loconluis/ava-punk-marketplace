// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract AvaPunk is ERC721 {
    constructor() ERC721("AvaPunks", "AVAPKS") {}
}