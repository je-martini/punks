// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.2 ;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract punks3 is ERC721 {
    constructor() ERC721("crypto-punks", "punks3"){
        
    }
}